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

locals {
  project = "project-01"
}


# vpc
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

# subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count      = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

# creating 4 ec2 instance
resource "aws_instance" "main" {
  for_each = var.ec2_map
  # we will get each.key and each.value

  ami           = each.value.ami 
  instance_type = each.value.instance_type

  subnet_id = element(aws_subnet.main[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.main))

  # 0%2 = 0
  # 1%2 = 1
  # 2%2 = 0 
  # 3%2 = 1


  tags = {
    Name = "${local.project}-instance-${each.key}"
  }
}


output "aws_subnet_id" {
  value = aws_subnet.main[0].id
}
