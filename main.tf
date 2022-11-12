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
    key = "bk-app/terraform.tfstate"
  }
}

provider "aws" {
  profile = "personal"
  region = "ap-southeast-1"
}

