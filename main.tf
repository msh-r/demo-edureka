provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "k8s_sg" {
  name        = "k8s_sg"
  description = "Security group for Kubernetes instances"
  vpc_id      = "vpc-08391e911181d5dd7"  # Replace with your VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (not safe for production)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP traffic
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "k8s" {
  count         = 3
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  key_name      = "edureka3"
  
  # ✅ Attach the Security Group Here
  vpc_security_group_ids = [aws_security_group.k8s_sg.id] 

  tags = {
    Name = count.index == 0 ? "k8s-master" : "k8s-worker-${count.index}"
  }
}
