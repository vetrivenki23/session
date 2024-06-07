
output "instance_id" {
  description = "The ID of the instance"
  value       = aws_instance.example.id
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ${var.ec2_keypath} ec2-user@${aws_instance.example.public_ip}"
}
