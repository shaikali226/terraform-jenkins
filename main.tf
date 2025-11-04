provider "aws" {
  region = var.aws_region
}

# Security Group for SSH and HTTP
resource "aws_security_group" "ec2_sg" {
  name        = "jenkins-ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-ec2-sg"
  }
}

# Key Pair (use existing .pem public key)
resource "aws_key_pair" "deployer_key" {
  key_name   = "aws-venkat-key-pair.pem"
  public_key = var.ssh_public_key
}

# EC2 Instance
resource "aws_instance" "jenkins_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer_key.key_name
  security_groups = [aws_security_group.ec2_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Deployed via Terraform + Jenkins to create ec2  🚀</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "jenkins-terraform-ec2"
  }
}

output "public_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}

