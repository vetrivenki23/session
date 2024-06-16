provider "aws" {
  region = "us-east-1" # Specify your desired AWS region
}

resource "aws_elasticache_parameter_group" "redis" {
  name        = "redis-default-parameters"
  family      = "redis6.x" # Adjust based on your Redis version
  description = "Custom parameter group for Redis"

  parameter {
    name  = "requirepass"
    value = "your_redis_password" # Replace with your desired Redis password
  }
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "redis-subnet-group"
  subnet_ids = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"] # Replace with your subnet IDs
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "my-redis-cluster"
  engine               = "redis"
  engine_version       = "6.x"            # Adjust based on your desired Redis version
  node_type            = "cache.t3.small" # Adjust based on your desired instance type
  num_cache_nodes      = 1                # Adjust based on your desired number of nodes
  parameter_group_name = aws_elasticache_parameter_group.redis.name
  subnet_group_name    = aws_elasticache_subnet_group.redis.name

  tags = {
    Name = "My Redis Cluster"
  }
}
