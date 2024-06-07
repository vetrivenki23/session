provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-01ca463d85a7b8110" # Change this to a valid AMI ID in your region
  instance_type = "t2.micro"
  key_name      = "us-east-2" # Change this to your key pair name

  user_data = file("${path.module}/app1-install.sh")

  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]

  tags = {
    Name = "example-instance"
  }


}




output "instance_id" {
  description = "The ID of the instance"
  value       = aws_instance.example.id
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i D:\\Venkat\\Tech_Learnings\\Session\\us-east-2.pem ec2-user@${aws_instance.example.public_ip}"
}
