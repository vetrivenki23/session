provider "aws" {
  region = "us-east-2" # Replace with your preferred AWS region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a" # Specify AZ for subnet1
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b" # Specify a different AZ for subnet2
}

resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.main.id

  // Define your security group rules here as per your requirements
  // Example:
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }
}

resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_lb" "example" {
  name               = "example-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    aws_subnet.subnet1.id,
    aws_subnet.subnet2.id,
  ]
}

resource "aws_lb_target_group" "tg1" {
  name     = "example-tg1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group" "tg2" {
  name     = "example-tg2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "404"
      message_body = "Not Found"
    }
  }
}

resource "aws_lb_listener_rule" "tg1_rule" {
  listener_arn = aws_lb_listener.example.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg1.arn
  }
  condition {
    path_pattern {
      values = ["/tg1"]
    }
  }
}

resource "aws_lb_listener_rule" "tg2_rule" {
  listener_arn = aws_lb_listener.example.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg2.arn
  }
  condition {
    path_pattern {
      values = ["/tg2"]
    }
  }
}

resource "aws_instance" "example_instance1" {
  ami           = "ami-0db513e73ed5a7faa" # Replace with your AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet1.id
  user_data     = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>TG1 from $(hostname -f)</h1>" > /var/www/html/index.html
  EOF
  tags = {
    Name = "target1"
  }
}

resource "aws_instance" "example_instance2" {
  ami           = "ami-0db513e73ed5a7faa" # Replace with your AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet2.id # Ensure instance is in a different subnet
  user_data     = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>TG2 from $(hostname -f)</h1>" > /var/www/html/index.html
  EOF
  tags = {
    Name = "target2"
  }
}
