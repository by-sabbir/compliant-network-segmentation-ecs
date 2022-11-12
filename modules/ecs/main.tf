resource "aws_ecs_cluster" "task_1" {
  name = "ecs-cluster"
  setting {
    name = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "ecs-cluster"
    Project = "task-1"
    Billing = "task-1"
  }
}

resource "aws_ecs_cluster_capacity_providers" "cap" {
  cluster_name =aws_ecs_cluster.task_1.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "task_1" {
  family = "task-1"
  container_definitions = file("modules/ecs/containers/service.json")

  network_mode = "awsvpc"
  requires_compatibilities = [ "FARGATE" ]
  memory = "1024"
  cpu = "512"
  execution_role_arn = var.ecs_role.arn
  task_role_arn = var.ecs_role.arn
  
  tags = {
    Name = "task-definition"
    Project = "task-1"
    Billing = "task-1"
  }
}

resource "aws_ecs_service" "task_1" {
  name = "task-1"
  cluster = aws_ecs_cluster.task_1.id
  task_definition = aws_ecs_task_definition.task_1.arn
  desired_count = 1
  launch_type = "FARGATE"

  lifecycle {
    ignore_changes = [desired_count]
  }

  network_configuration {
    subnets = [
      var.ecs_subnet_a.id,
      var.ecs_subnet_b.id,
      var.ecs_subnet_c.id
    ]
    security_groups = [var.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.ecs_target_group.arn
    container_name = "bk-app"
    container_port = 80
  }
}

