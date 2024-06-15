/*locals {
  environment = var.environment
  app_name = var.app_name
  instance_name  = "${local.environment}-${local.app_name}"
}
*/

# if environment is prod, trigger 2 instances, else 1

locals {
 instance_count = var.environment == "prod"?2:1
}

resource "aws_instance" "my-ec2" {
  count = local.instance_count
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  user_data = file("userdata.sh")
  #key_name = var.ec2_keyname
  tags = {
    Name = "${var.app_name}-${count.index+1}"
  }
}



