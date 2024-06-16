resource "aws_instance" "my-ec2" {
  count = length(var.ec2_type)
  ami           = var.ec2_ami
  instance_type = var.ec2_type[count.index]
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  user_data = file("userdata.sh")
  #key_name = var.ec2_keyname
  tags = {
    Name = "My-EC2"
  }
}



