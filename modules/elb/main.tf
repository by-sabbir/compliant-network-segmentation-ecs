resource "aws_lb" "elb" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  
  security_groups    = [ var.load_balancer_sg.id ]
  
  subnets            = [
    var.load_balancer_subnet_a.id,
    var.load_balancer_subnet_b.id,
    var.load_balancer_subnet_c.id
  ]

  tags = {
    Name = "ecs-alb"
    Project = "task-1"
    Billing = "task-1"
  }
}

resource "aws_lb_target_group" "ecs" {
  name     = "ecs-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    timeout             = 10
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = "ecs-tg"
    Project = "task-1"
    Billing = "task-1"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs.arn
  }
}