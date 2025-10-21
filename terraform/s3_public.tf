resource "aws_s3_bucket" "public_bucket" {
  bucket = "${var.prefix}-public-bucket"
  acl    = "public-read"
  tags = { Name = "${var.prefix}-public-bucket" }
}

