
resource "aws_security_group" "main" {
  name = "my-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main" {
  ami           = "ami-0fa91bc90632c73c9"
  instance_type = "t3.micro"

  # instance creation will wait for the vpc to create
  vpc_security_group_ids = [aws_security_group.main.id] #
  depends_on = [aws_security_group.main] # implecit dependence
}
