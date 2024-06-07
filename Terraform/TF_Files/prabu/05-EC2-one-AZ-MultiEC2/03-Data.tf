data "aws_security_group" "web_server_east2_sg" {
  name = "web_sg"
}

data "aws_availability_zones" "east2_az" {}