resource "aws_instance" "tf_ec2" {
//ami           = "ami-07d77b1e82b231201"   # us-east-1
  ami         = var.ec2_ami
  instance_type = var.ec2_type             

  tags = {
    Name = "Prabu-EC2"
  }
}
