output "ec2_public_ip" {
  description = "EC2 public IP"
  value       = module.ec2_instance.ec2_public_ip
}

output "ec2_private_ip" {
  description = "EC2 private IP"
  value       = module.ec2_instance.ec2_private_ip
}

output "ec2_sg_web" {
  description = "EC2 sg web"
  value       = module.ec2_sg.sg_web_id
}

output "ec2_sg_ssh" {
  description = "EC2 sg ssh"
  value       = module.ec2_sg.sg_ssh_id
}