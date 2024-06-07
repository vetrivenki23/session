output "public_ip" {
  value = aws_instance.tf_ec2.public_ip
}

output "sg_id" {
  value = data.aws_security_group.web_server.id
}