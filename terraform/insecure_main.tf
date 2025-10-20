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

# Insecure S3: public-read, no versioning
resource "aws_s3_bucket" "public_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
}

# No versioning, no encryption -> insecure

# Insecure security group open to internet
resource "aws_security_group" "open_sg" {
  name        = "open_sg"
  description = "Open security group for demo"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Insecure IAM admin policy (wildcard)
resource "aws_iam_policy" "admin_policy" {
  name        = "admin_policy_demo"
  description = "Admin policy with * (insecure)"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = "*",
      Effect   = "Allow",
      Resource = "*"
    }]
  })
}

