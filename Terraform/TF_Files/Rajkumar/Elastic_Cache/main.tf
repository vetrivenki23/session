resource "aws_elasticache_parameter_group" "redis" {
  name        = "redis-default-parameters"
  family      = "redis6.x"
  description = "Custom parameter group for Redis"

  parameter {
    name  = "auth-token"
    value = "test123"
  }
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "redis-subnet-group"
  subnet_ids = ["subnet-03015b37b2e63fb82"]
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "my-redis-cluster"
  engine               = "redis"
  engine_version       = "6.x"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  parameter_group_name = "default.redis6.x" # Use the default parameter group
  tags = {
    Name = "My Redis Cluster"
  }
}
