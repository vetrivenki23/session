module "ec2_instance" {
    source="./Modules/01-EC2"
    md_ec2_ami= var.ec2_ami
    md_ec2_type = var.ec2_type
    md_sg_id = [module.security_group.md_web_sg_id]
}

module "security_group" {
    source="./Modules/02-SG"    
}


