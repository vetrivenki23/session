resource "aws_instance" "tf_ec2_east2" {
//ami           = "ami-07d77b1e82b231201"   # us-east-1
  ami         = var.ec2_ami_east2
  instance_type = var.ec2_type             
  count=length(data.aws_availability_zones.east2_az.names)
  user_data = file("userdata2.sh")
  
  vpc_security_group_ids = [data.aws_security_group.web_server_east2_sg.id]

  availability_zone = data.aws_availability_zones.east2_az.names[count.index]

  tags = {
    Name = "Prabu-EC2-east2-${data.aws_availability_zones.east2_az.names[count.index]}"
  }
}
