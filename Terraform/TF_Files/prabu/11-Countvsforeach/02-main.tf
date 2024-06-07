variable "instance_names" {
  type    = list(string)
  default = ["web-01", "web-02", "web-03"]
}
/*
# Using `count` to create multiple instances
resource "aws_instance" "example_count" {
  count = length(var.instance_names)

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = count.index
  }
}
*/
# # Using `for_each` to create multiple instances
 locals {
   instance_map = { for name in var.instance_names : name => name }
 }

 resource "aws_instance" "example_for_each" {
   for_each = local.instance_map
  
   ami           = "ami-0c55b159cbfafe1f0"
   instance_type = "t2.micro"

   tags = {
     Name = each.value
   }

 }