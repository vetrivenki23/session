
resource "aws_security_group" "web-sg" {
    name = "prabu_web_sg"

    ingress {
        description = "WEB-SG"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

  }

resource "aws_security_group" "ssh-sg" {
    name = "prabu_ssh_sg"

    ingress {
        description = "SSH-SG"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

     egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
