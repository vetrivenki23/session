provider "aws" {
  region = "us-east-2" # Change this to your preferred region
}

resource "aws_security_group" "example" {
  name        = "web_ssh"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-security-group"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-01ca463d85a7b8110" # Change this to a valid AMI ID in your region
  instance_type = "t2.micro"
  key_name      = "us-east-2" # Change this to your key pair name

  vpc_security_group_ids = [aws_security_group.example.id]

  tags = {
    Name        = "MyFirstEC2"
    Environment = "dev"
    Project     = "terraform-example"
  }
}

output "instance_id" {
  description = "The ID of the instance"
  value       = aws_instance.example.id
}

output "public_ip" {
  description = "The public IP of the instance"
  value       = aws_instance.example.public_ip
}
