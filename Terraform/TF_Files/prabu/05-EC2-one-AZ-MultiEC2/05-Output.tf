output "east2_public_ip" {
  value = aws_instance.tf_ec2_east2[*].public_ip
}

output "east2_sg_id" {
  value = data.aws_security_group.web_server_east2_sg.id
}
