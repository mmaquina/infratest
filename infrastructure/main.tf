terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.50.0"
    }
  }
  backend "s3" {
    bucket = "s3-backend-tfstates"
    key    = "backend-tfstate/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_ecr_repository" "ecr_repository" {
    name = "ecr-repo"
}


resource "aws_s3_bucket" "bucket" {
    bucket = "s3-backend-tfstates"
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

