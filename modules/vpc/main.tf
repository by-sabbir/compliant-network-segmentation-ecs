data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "task-1-vpc"
  cidr = var.cidr_block

  azs             = tolist(data.aws_availability_zones.available.names)
  # private_subnets = var.private_subnets_list
  public_subnets  = var.public_subnets_list
  database_subnets = var.db_subnets_list
  
  enable_dns_support = true
  enable_dns_hostnames = true

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Name = "ecs-vpc"
    Project = "task-1"
  }
  database_route_table_tags = {
    Name = "rtb-task-1-db"
  }
  database_subnet_group_name = "db-subnet-grp-task-1"
  database_subnet_tags = {
    Name = "db-subnets-task-1"
  }
  default_security_group_name = "sg-task-1"

  private_route_table_tags = {
    Name = "rtb-task-1-private"
  }
  private_subnet_tags = {
    Name = "private-subnets-task-1"
  }

}
