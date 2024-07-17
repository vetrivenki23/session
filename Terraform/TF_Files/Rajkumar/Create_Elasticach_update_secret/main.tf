provider "aws" {
  region = "us-east-2"
}

data "aws_secretsmanager_secret" "elastic_new_key" {
  name = "elastic_new_auth_key"
}

data "aws_secretsmanager_secret_version" "elastic_new_key" {
  secret_id = data.aws_secretsmanager_secret.elastic_new_key.id
}

resource "aws_elasticache_replication_group" "myelasticach" {
  replication_group_id = "my-replication-group"
  description          = "ElastiCache replication group"
  node_type            = "cache.t2.micro"
  num_cache_clusters   = 2
  engine               = "redis"
  engine_version       = "6.x"
  parameter_group_name = "default.redis6.x"
  port                 = 6379

  auth_token = data.aws_secretsmanager_secret_version.elastic_new_key.secret_string

  automatic_failover_enabled = true
  apply_immediately          = true

  lifecycle {
    create_before_destroy = true
  }
}

output "elasticache_auth_token" {
  value     = data.aws_secretsmanager_secret_version.elastic_new_key.secret_string
  sensitive = true
}
