terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source = "ContentSquare/random"
      version = "3.1.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

# bucket = yogesh-s3-7418  previous bucket name
resource "aws_s3_bucket" "demo-bucket" {
  bucket = "yogesh-s3-bucket-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "bucket-data" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  source = "../Readme.md"
  key    = "Readme.md"
}

output "name" {
  value = random_id.rand_id.hex
}
