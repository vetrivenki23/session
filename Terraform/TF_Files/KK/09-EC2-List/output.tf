output "ec2_public_ip" {
  description = "EC2 public IP"
  value       = [for instance in aws_instance.my-ec2:instance.public_ip]
}

/*output "ec2_private_ip" {
  description = "EC2 private IP"
  value       = [for instance in aws_instance.my-ec2:instance.private_ip]
}*/

#Legacy 
output "ec2_splat_operator_public_ip" {
  description = "EC2 public IP legacy"
  value       = aws_instance.my-ec2.*.public_ip
}

#Latest
output "ec2_splat_latest_public_ip" {
  description = "EC2 public IP latest"
  value       = aws_instance.my-ec2[*].public_ip
}

/*output "ssh_command" {
  description = "SSH command to connect to the instance"
  value = "ssh -i ${var.ec2_keypath} ec2-user@${aws_instance.my-ec2.public_ip}"
}*/
