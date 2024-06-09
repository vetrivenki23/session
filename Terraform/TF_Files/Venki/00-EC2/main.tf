resource "aws_instance" "my-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type

  tags = {
    Name = "My-EC2"
  }
}
