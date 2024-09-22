output "sg_ssh_id" {
  description = "EC2 public IP"
  value       = aws_security_group.vpc-ssh.id
}

output "sg_web_id" {
  description = "EC2 public IP"
  value       = aws_security_group.vpc-web.id
}