provider "aws" {
  region = "us-east-2" # Replace with your preferred AWS region
}

# Define the AWS VPC
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "tf-test"
  }
}

resource "aws_subnet" "mysubnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "tf-test"
  }
}


resource "aws_elasticache_subnet_group" "mysubnetgroup" {
  name       = "elasticache-subnet-group"
  subnet_ids = [aws_subnet.mysubnet.id]
}

resource "aws_security_group" "elastic_sg" {
  name        = "elasticache-sg"
  description = "Security group for ElastiCache"

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_replication_group" "myelasticach" {
  replication_group_id = "myelasticach"
  description          = "elasticach with authentication"
  node_type            = "cache.t2.micro"
  num_cache_clusters   = 1
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.mysubnetgroup.name
  security_group_ids   = [aws_security_group.elastic_sg.id]
  parameter_group_name = "default.redis5.0"
  engine_version       = "5.0.6"

  transit_encryption_enabled = true
  auth_token                 = "abcdefgh1234567890"
  auth_token_update_strategy = "ROTATE"
}

# Output the ID of the AWS security group
output "elastic_sg_id" {
  value = aws_security_group.elastic_sg.id
}
