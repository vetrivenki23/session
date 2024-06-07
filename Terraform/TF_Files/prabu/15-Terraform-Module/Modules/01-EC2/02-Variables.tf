# String variable
variable "md_ec2_ami" {
  description = "A string variable"
  type        = string
  #default     = "ami-01ca463d85a7b8110"
}

variable "md_ec2_type" {
  description = "A string variable"
  type        = string
  #default     = "t2.micro"
}


variable "md_sg_id" {
  description = "A string variable"
  type        = list(string)
  #default     = "t2.micro"
}