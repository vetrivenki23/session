module "ec2_sg" {
  source = "./modules/security_group"
  sg_ssh = "module_sg_ssh"
  sg_web = "module_sg_web"
}

module "ec2_instance" {
  source = "./modules/aws_instance"
  aws_region = "us-east-2"
  ec2_ami = "ami-0db513e73ed5a7faa"
  ec2_type = "t2.micro"
  sg_ids = [module.ec2_sg.sg_ssh_id, module.ec2_sg.sg_web_id]
}


