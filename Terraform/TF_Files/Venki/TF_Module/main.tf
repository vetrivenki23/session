module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = "t2.micro"
  key_name               = "us-east-2"
  vpc_security_group_ids = ["sg-036e8eff796f32b2d"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
