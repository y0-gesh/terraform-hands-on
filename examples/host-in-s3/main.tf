terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "portfolio-bucket" {
  bucket = "terraform-learning-portfolio-s3"
}

resource "aws_s3_bucket_public_access_block" "portfolio-bucket" {
  bucket = aws_s3_bucket.portfolio-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "portfolio-bucket" {
  bucket = aws_s3_bucket.portfolio-bucket.id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject",
          Resource  = "arn:aws:s3:::${aws_s3_bucket.portfolio-bucket.id}/*"
        }
      ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "portfolio-bucket" {
  bucket = aws_s3_bucket.portfolio-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.portfolio-bucket.bucket
  source = "../static-website/index.html"
  key    = "index.html"
  content_type = "text/html"
}
resource "aws_s3_object" "style_css" {
  bucket = aws_s3_bucket.portfolio-bucket.bucket
  source = "../static-website/style.css"
  key    = "style.css"
  content_type = "text/css"
}
resource "aws_s3_object" "favicon_svg" {
  bucket = aws_s3_bucket.portfolio-bucket.bucket
  source = "../static-website/assets/favicon.svg"
  key    = "favicon.svg"
  content_type = "text/svg"
}

output "name" {
  value = aws_s3_bucket_website_configuration.portfolio-bucket.website_endpoint
}