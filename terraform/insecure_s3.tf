# Vulnerable: Bucket S3 público y sin cifrado
resource "aws_s3_bucket" "public_bucket" {
  bucket = "insecure-demo-bucket-${random_id.id.hex}"
}

resource "aws_s3_bucket_acl" "public_acl" {
  bucket = aws_s3_bucket.public_bucket.id
  acl    = "public-read" # ❌ Vulnerable
}

resource "aws_s3_bucket_versioning" "versioning_disabled" {
  bucket = aws_s3_bucket.public_bucket.id
  versioning_configuration {
    status = "Suspended" # ❌ Sin versionado
  }
}

resource "random_id" "id" {
  byte_length = 4
}

