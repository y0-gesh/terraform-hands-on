terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "yogesh-s3-bucket-7418"
    key = "backend.tfstate"
    region = "eu-north-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

#create instance
resource "aws_instance" "myserver" {
  ami = "ami-0fa91bc90632c73c9"
  instance_type = "t3.micro"
  tags = {
    Name="SampleServer"
  }
}

# Create a VPC
# resource "aws_vpc" "example" {
#   cidr_block = "10.0.0.0/16"
# }