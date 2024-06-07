resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.nano"

  lifecycle {
    ignore_changes = [
      #tags,              # Ignore changes to tags
      security_groups,   # Ignore changes to security groups
    ]
  }
}