#region
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}


#instance type
variable "ec2_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

#key name
variable "ec2_keyname" {
  default = "us-east-2"
}


