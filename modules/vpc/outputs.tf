
output "db_subnets" {
  value = module.vpc.database_subnets
}
output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_public_ip" {
  value = module.vpc.nat_public_ips
}

output "vpc_arn" {
  value = module.vpc.vpc_arn
}

output "vpc_azs" {
  value = module.vpc.azs
}