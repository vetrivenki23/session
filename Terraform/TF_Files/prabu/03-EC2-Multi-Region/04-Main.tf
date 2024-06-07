resource "aws_instance" "tf_ec2_east2" {
//ami           = "ami-07d77b1e82b231201"   # us-east-1
  ami         = var.ec2_ami_east2
  instance_type = var.ec2_type             

  user_data = file("userdata2.sh")
  
  vpc_security_group_ids = [data.aws_security_group.web_server_east2_sg.id]

  tags = {
    Name = "Prabu-EC2-east2"
  }
}

resource "aws_instance" "tf_ec2_west2" {
  provider = aws.DR-Region
  ami         = var.ec2_ami_west2
  instance_type = var.ec2_type             

  user_data = file("userdata1.sh")
  
  //vpc_security_group_ids = [data.aws_security_group.web_server_west2_sg.id]

  tags = {
    Name = "Prabu-EC2-west2"
  }
}