resource "aws_instance" "my-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name = "us-east-2"
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  user_data = file("userdata.sh")
  
  /* to copy a file from local to EC2 instance */
  provisioner "file" {
    /*source      = "C:\\Users\\kk198\\session\\Terraform\\TF_Files\\KK\\14-EC2-File Provisioner\\test-file.txt" */
    content     = "I want to copy this string to the destination file server.txt"
    destination = "content.txt"
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



