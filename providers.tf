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

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.terraform_state.arn]
  }

  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.terraform_state.arn}/*"]
  }
}

data "aws_iam_policy_document" "dynamodb_policy" {
  statement {
    actions   = ["dynamodb:PutItem", "dynamodb:GetItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.terraform_state_lock.arn]
  }
}

resource "aws_iam_role" "s3_role" {
  name = "s3_access_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "s3.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role" "dynamodb_role" {
  name = "dynamodb_access_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "dynamodb.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_attachment" {
  role       = aws_iam_role.s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" #data.aws_iam_policy_document.s3_policy.arn
}

resource "aws_iam_role_policy_attachment" "dynamodb_attachment" {
  role       = aws_iam_role.dynamodb_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess" # data.aws_iam_policy_document.dynamodb_policy.arn
}