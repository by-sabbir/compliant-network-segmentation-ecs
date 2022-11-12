resource "aws_lb" "alb" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.load_balancer_sg]
  subnets            = var.public_subnet_lb

  enable_deletion_protection = true

  tags = {
    Name = "ecs-alb"
    Project = "task-1"
    Billing = "task-1"
  }
}

resource "aws_lb_target_group" "ecs" {
  name     = "ecs"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 300
    path                = "/healthcheck"
    timeout             = 60
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = "ecs-alb"
    Project = "task-1"
    Billing = "task-1"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs.arn
  }
}
