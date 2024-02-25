terraform {
  required_version = "~> 1.5.4"
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
      Version     = var.git_hash,
      Project     = var.project,
      Application = var.application,
      Owner       = var.owner
    }
  }
}