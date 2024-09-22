resource "aws_instance" "my-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  vpc_security_group_ids = var.sg_ids
  user_data = file("userdata.sh")
  #key_name = var.ec2_keyname
  tags = {
    Name = "My-EC2"
  }
}



