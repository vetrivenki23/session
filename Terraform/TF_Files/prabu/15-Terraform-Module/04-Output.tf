output "root_public_ip" {
  value = module.ec2_instance.md_public_ip
}

output "root_sg_id" {
  value = module.security_group.md_web_sg_id
}
