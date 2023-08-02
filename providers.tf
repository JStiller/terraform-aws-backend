terraform {
  required_version = "~> 0.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.9"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Terraform   = "true",
      Environment = var.environment,
      Version     = var.version,
      Project     = var.project
    }
  }
}