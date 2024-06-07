# String variable
variable "ec2_ami" {
  description = "A string variable"
  type        = string
  default     = "ami-01ca463d85a7b8110"
}

variable "ec2_type" {
  description = "A string variable"
  type        = string
  default     = "t2.micro"
}