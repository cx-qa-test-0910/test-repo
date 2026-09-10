provider "aws" {
  region = "us-east-1"
}

# Sample IaC misconfiguration for scanner testing: security group open to the world
resource "aws_security_group" "insecure_sg" {
  name        = "insecure-sg"
  description = "Intentionally insecure for IaC scanner testing"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Sample IaC misconfiguration: public S3 bucket
resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "cx-qa-test-insecure-bucket"
  acl    = "public-read"
}
