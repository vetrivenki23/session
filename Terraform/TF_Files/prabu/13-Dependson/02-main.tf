# Define an AWS S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "123-techlearning-example-bucket-name"

  # S3 bucket configuration...
 depends_on = [aws_instance.example]  
  tags = {
    Name = "example-bucket"
  }
}

# Define an AWS EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  # Other instance attributes...

  tags = {
    Name = "example-instance"
  }

  # Use the depends_on attribute to specify the dependency on the S3 bucket
 
}