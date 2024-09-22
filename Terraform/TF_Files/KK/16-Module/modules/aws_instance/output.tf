output "ec2_public_ip" {
  description = "EC2 public IP"
  value       = aws_instance.my-ec2.public_ip
}

output "ec2_private_ip" {
  description = "EC2 private IP"
  value       = aws_instance.my-ec2.private_ip
}