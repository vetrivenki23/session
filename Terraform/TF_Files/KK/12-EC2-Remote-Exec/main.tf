resource "aws_instance" "my-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name = "us-east-2"
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  user_data = file("userdata.sh")
  
provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("C:\\Users\\kk198\\Downloads\\us-east-2.pem")
      timeout     = "4m"
   }

  tags = {
    Name = "My-EC2"
  }
}



