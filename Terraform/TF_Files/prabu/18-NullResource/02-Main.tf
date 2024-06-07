/*
resource "null_resource" "null_resource_simple" {
  provisioner "local-exec" {
    command = "echo Hello World"
  }
}
*/

resource "aws_instance" "tf_ec2" {
ami           = "ami-01ca463d85a7b8110"   # us-east-1
  #ami         = var.ec2_ami
  instance_type = "t2.nano"            

  #user_data = file("userdata.sh")
  
 # vpc_security_group_ids = [data.aws_security_group.web_server.id]

  tags = {
    Name = "Prabu-EC2"
  }
}


resource "null_resource" "null_resource_simple" {

  triggers = {
    id = aws_instance.tf_ec2.id
  }
  provisioner "local-exec" {
    command = <<-EOT
      echo ${aws_instance.tf_ec2.public_ip} > hello.txt
    EOT
  }
}