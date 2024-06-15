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

#key name
variable "ec2_keyname" {
  default = "us-east-2"
}

variable "ec2_keypath" {
  description = "A String Variable"
  type = string
  default = "C:\\Users\\kk198\\Downloads\\us-east-2.pem"
}