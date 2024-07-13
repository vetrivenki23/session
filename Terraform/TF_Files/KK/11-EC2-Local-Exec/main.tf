resource "aws_instance" "my-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  user_data = file("userdata.sh")
  #key_name = var.ec2_keyname
  
  /*provisioner "local-exec" {
    command = "echo ${aws_instance.my-ec2.private_ip} >> private_ips.txt"
  }*/

  provisioner "local-exec" {
    command = "echo 'Instance created' > create.log"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Instance destroyed' > destroy.log"
  }

  tags = {
    Name = "My-EC2"
  }
}



