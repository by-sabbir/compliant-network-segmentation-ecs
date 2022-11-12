provider "aws" {
  profile = "personal"
  region = "ap-southeast-1"
}


resource "aws_efs_file_system" "fs" {
  creation_token = "ecs-efs-bk-app"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}

resource "aws_efs_access_point" "ap" {
  file_system_id = aws_efs_file_system.fs.id
}

resource "aws_ecs_task_definition" "service" {
  family = "service"
  container_definitions = file("containers/service.json")
  memory = "512"
  cpu = "256"
  network_mode = "awsvpc"

  tags = {
    Name = "bk-app"
    Project = "task-1"
    Billing = "task-1"
  }

  volume {
    name = "service-storage"

    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.fs.id
      root_directory          = "/opt/data"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2999

      authorization_config {
        access_point_id = aws_efs_access_point.ap.id
        iam             = "ENABLED"
      }
    }
  }
}

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "ecs-bk-app"
  
  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/bk-app"
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  autoscaling_capacity_providers = {
    one = {
      auto_scaling_group_arn         = var.asg_arn
      managed_termination_protection = "ENABLED"

      managed_scaling = {
        maximum_scaling_step_size = 5
        minimum_scaling_step_size = 1
        status                    = "ENABLED"
        target_capacity           = 60
      }

      default_capacity_provider_strategy = {
        weight = 60
        base   = 20
      }
    }
  }

  tags = {
    Name = "ecs"
    Project     = "task-1"
    Billing = "task-1"
  }
}