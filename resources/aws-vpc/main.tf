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

# Create a VPC
resource "aws_vpc" "my-vpc-1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc-1"
  }
}

# Private subnet
resource "aws_subnet" "private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.my-vpc-1.id
  tags = {
    Name= "private-subnet"
  }
}
# Public subnet
resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.my-vpc-1.id
  tags = {
    Name= "public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "my-igw-1" {
  vpc_id = aws_vpc.my-vpc-1.id
  tags = {
    Name = "my-igw-1"
  }
}

# Routing table
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw-1.id 
  }
}

resource "aws_route_table_association" "public-subnet" {
  route_table_id = aws_route_table.my-rt.id
  subnet_id = aws_subnet.public-subnet.id

}


# Create instance EC2
# Note: EC2 instance is not free service

# resource "aws_instance" "myserver" {
#   ami = "ami-0fa91bc90632c73c9"
#   instance_type = "t3.micro"
#   subnet_id = aws_subnet.public-subnet.id

#   tags = {
#     Name="SampleServer"
#   }
# }

