output "vpc_id" {
  value = module.vpc.vpc.id
}

output "load_balancer_subnet_a" {
  value = module.vpc.load_balancer_subnet_a
}

output "load_balancer_subnet_b" {
  value = module.vpc.load_balancer_subnet_b
}

output "load_balancer_subnet_c" {
  value = module.vpc.load_balancer_subnet_c
}

output "ecs_subnet_a" {
  value = module.vpc.ecs_subnet_a
}

output "ecs_subnet_b" {
  value = module.vpc.ecs_subnet_b
}

output "ecs_subnet_c" {
  value = module.vpc.ecs_subnet_c
}

output "load_balancer_sg" {
  value = module.vpc.load_balancer_sg
}

output "ecs_sg" {
  value = module.vpc.ecs_sg
}