#region
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

#ami
variable "ec2_ami" {
  description = "EC2 ami"
  type        = string
  default     = "ami-0db513e73ed5a7faa"
}

#instance type
variable "ec2_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "sg_ids" {
  description = "EC2 sg ids"
  type        = list(string)
}

