output "sg_name_lb" {
  value = aws_security_group.load_balancer.id
}

output "sg_name_task" {
  value = aws_security_group.ecs_task.id
}