variable "create_instance" {
  type    = bool
  default = false
}

resource "aws_instance" "example" {
  count = var.create_instance ? 1 : 0  # Conditionally create 1 instance based on 'create_instance' variable

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}