output "ecs_cluster" {
  value = aws_ecs_cluster.task_1
}

output "ecs_service" {
  value = aws_ecs_service.task_1
}