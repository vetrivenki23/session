resource "aws_instance" "my-ec2" {
  count = length(data.aws_availability_zones.east2_az.names)
  availability_zone = data.aws_availability_zones.east2_az.names[count.index]
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.ec2_type
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  user_data = file("userdata.sh")
  #key_name = var.ec2_keyname
  tags = {
    Name = "My-EC2"
  }
}



