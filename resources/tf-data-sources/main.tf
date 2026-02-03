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

data "aws_ami" "name" {
  most_recent = true
  owners      = ["amazon"]
}

data "aws_security_group" "name" {
  tags = {
    myserver = "MySG"
    ENV = "PROD"
  }
}

#VPC Id
data "aws_vpc" "name" {
  tags = {
    ENV  = "PROD"
    Name = "my-vpc"
  }
}

# Availability zone
data "aws_availability_zone" "names" {
  state = "available"
}

# To get the account details
data "aws_caller_identity" "name" {
}

# know aws region
data "aws_region" "name" {
}

output "aws_ami" {
  value = data.aws_ami.name.id
}

output "security_group" {
  value = data.aws_security_group.name.id
}

output "vpc_id" {
  value = data.aws_vpc.name.id
}

output "aws_zones" {
  value = data.aws_availability_zone.names
}

output "caller_info" {
  value = data.aws_caller_identity.name
}

output "region_name" {
  value = data.aws_region.name
}

# Subnet ID
data "aws_subnet" "name" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.name.id]
  }
}

#create instance
resource "aws_instance" "myserver" {
  ami             = data.aws_ami.name.id
  instance_type   = "t3.micro"
  subnet_id       = data.aws_subnet.name.id
  security_groups = [data.aws_security_group.name.id]

  tags = {
    Name = "SampleServer"
  }
}
