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
