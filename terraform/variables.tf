variable "region" {
  default = "us-east-1"
}
variable "bucket_name" {
  default = "insecure-demo-public-bucket-12345"
}
variable "vpc_id" {
  default = "vpc-xxxxxxxx"
}
variable "prefix" { default = "insecure-demo" }
variable "public_key" { 
  description = "SSH public key for EC2", 
  default = "" 
}

