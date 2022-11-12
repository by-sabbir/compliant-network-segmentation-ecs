terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.39.0"
    }
  }
  backend "s3" {
    profile = "personal"
    bucket = "tfstate-stored"
    region = "ap-southeast-1"
    key = "bk-app/bk-app-iac.tfstate"
  }
}

provider "aws" {
  profile = "personal"
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source = "./modules/alb"
  load_balancer_sg = module.vpc.load_balancer_sg
  load_balancer_subnet_a = module.vpc.load_balancer_subnet_a
  load_balancer_subnet_b = module.vpc.load_balancer_subnet_b
  load_balancer_subnet_c = module.vpc.load_balancer_subnet_c
  vpc = module.vpc.vpc
}