variable "ecs_role_arn" {
    default = "arn:aws:iam::368586151120:role/ecs-service"
}

variable "asg_arn" {
  default = "arn:aws:elasticloadbalancing:ap-southeast-1:368586151120:loadbalancer/app/ecs-alb/df8eab5927b84803"
}