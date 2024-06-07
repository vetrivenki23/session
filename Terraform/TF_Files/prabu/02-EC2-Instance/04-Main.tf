resource "aws_instance" "tf_ec2" {
//ami           = "ami-07d77b1e82b231201"   # us-east-1
  ami         = var.ec2_ami
  instance_type = var.ec2_type             

  user_data = file("userdata.sh")
  
  vpc_security_group_ids = [data.aws_security_group.web_server.id]

  tags = {
    Name = "Prabu-EC2"
  }
}
