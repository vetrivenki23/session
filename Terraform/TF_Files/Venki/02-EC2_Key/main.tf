resource "aws_instance" "example" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name      = var.ec2_keyname

  user_data = file("${path.module}/app1-install.sh")

  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]

  tags = {
    Name = "My-EC2"
  }

}



