

provider "aws" {
  region = "us-east-1"  
}


data "aws_ami" "example" {
  most_recent = true


   filter {
    name   = "name"
    values = ["al2023-ami-*"]
   
  }
  filter {
    name = "platform-details"
    values = ["Linux/UNIX"]
   
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }  
 
}


output "ami_id" {
  description = "Information about the AMI"
  value = {
    name = data.aws_ami.example.name
    id = data.aws_ami.example.id
    description = data.aws_ami.example.description
    architecture = data.aws_ami.example.architecture
    owner_alias = data.aws_ami.example.image_owner_alias
    platform_details = data.aws_ami.example.platform_details
  }
}




Userdata

resource "aws_instance" "tf_ec2" {
//ami           = "ami-07d77b1e82b231201"   # us-east-1
  count = length(data.aws_availability_zones.available.names)
  ami         = var.ec2_ami
  instance_type = var.ec2_type            


  user_data = file("userdata.sh")
 
  vpc_security_group_ids = [data.aws_security_group.web_server.id]


  availability_zone = data.aws_availability_zones.available.names[count.index]


  tags = {
    Name = "Raj-${data.aws_availability_zones.available.names[count.index]}"
  }


}

