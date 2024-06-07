# String variable
variable "ec2_ami_east2" {
  description = "A string variable"
  type        = string
  default     = "ami-01ca463d85a7b8110"
}

variable "ec2_ami_west2" {
  description = "A string variable"
  type        = string
  default     = "ami-002829755fa238bfa"
}


variable "ec2_type" {
  description = "A string variable"
  type        = string
  default     = "t2.micro"
}