terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = var.region
}

# Secure S3: private, versioning, server-side encryption
resource "aws_s3_bucket" "secure_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Security Group restricted (example: only SSH from a small range)
resource "aws_security_group" "restricted_sg" {
  name        = "restricted_sg"
  description = "Restricted SG for demo"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["203.0.113.0/24"] # example allowed admin net only
  }
}

# Least privilege IAM example (do not use wildcard)
data "aws_iam_policy_document" "example" {
  statement {
    sid    = "AllowS3List"
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.secure_bucket.arn
    ]
  }

  statement {
    sid    = "AllowS3PutGet"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.secure_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "limited" {
  name   = "limited_policy_demo"
  policy = data.aws_iam_policy_document.example.json
}

