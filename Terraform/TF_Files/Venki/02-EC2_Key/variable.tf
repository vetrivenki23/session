# String variable
variable "aws_region" {
  description = "A string variable"
  type        = string
  default     = "us-east-2"
}

variable "ec2_ami" {
  description = "A string variable"
  type        = string
  default     = "ami-01ca463d85a7b8110" #"us-east-2"
}

variable "ec2_type" {
  description = "A string variable"
  type        = string
  default     = "t2.micro"
}

variable "ec2_keyname" {
  description = "A string variable"
  type        = string
  default     = "us-east-2"
}

variable "ec2_keypath" {
  description = "A string variable"
  type        = string
  default     = "D:\\Venkat\\Tech_Learnings\\Session\\us-east-2.pem"
}
