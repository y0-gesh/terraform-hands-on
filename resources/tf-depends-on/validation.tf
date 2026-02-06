
resource "aws_security_group" "main" {
  name = "my-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"

}

resource "aws_instance" "main" {
  ami           = "ami-0fa91bc90632c73c9"
  instance_type = "t3.micro"
  
  subnet_id                   = aws_subnet.private_subnet.id
  associate_public_ip_address = false
  depends_on                  = [aws_security_group.main] # implecit dependence

  lifecycle {
    # adding precondition to check the security-group is created = checking status of the security-group 

    precondition {
      condition     = aws_security_group.main.id != ""
      error_message = "Security group ID must not be blank"

    }

    # checking instance has a public IP address after creation
    postcondition {
      condition     = self.public_ip != ""
      error_message = "Public IP is not generated"

    }

  }
}
