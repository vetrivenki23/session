resource "aws_instance" "tf_ec2" {
//ami           = "ami-07d77b1e82b231201"   # us-east-1
  ami         = var.md_ec2_ami
  instance_type = var.md_ec2_type             
  vpc_security_group_ids = var.md_sg_id
  user_data = <<-EOF
  #!/bin/sh
  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl enable httpd
  sudo service httpd start
  sudo echo '<h1>Welcome to Tech Learnings : Prabu</h1>' | sudo tee /var/www/html/index.html
  EOF
  

  tags = {
    Name = "Prabu-EC2"
  }
}
