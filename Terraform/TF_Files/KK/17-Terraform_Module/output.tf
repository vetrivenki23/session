output "ec2_public_ip" {
  description = "EC2 public IP"
  value       = module.ec2_instance.public_ip
}

output "ec2_private_ip" {
  description = "EC2 private IP"
  value       = module.ec2_instance.private_ip
}