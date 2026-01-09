
# Create instance EC2
# Note: EC2 instance is not free service

# resource "aws_instance" "nginxserver" {
#   ami                         = "ami-0fa91bc90632c73c9"
#   instance_type               = "t3.micro"
#   subnet_id                   = aws_subnet.public-subnet.id
#   vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
#   associate_public_ip_address = true

#   user_data = <<-EOF
#             #!/bin/bash
#             sudo yum install nginx -y
#             sudo systemctl start nginx
#             EOF

#   tags = {
#     Name = "NginxServer"
#   }
# }
