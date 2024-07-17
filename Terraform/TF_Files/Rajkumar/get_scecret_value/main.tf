provider "aws" {
  region = "us-east-2"
}

data "aws_secretsmanager_secret" "elastic_new_key" {
  name = "elastic_new_auth_key"
}

data "aws_secretsmanager_secret_version" "elastic_new_key" {
  secret_id = data.aws_secretsmanager_secret.elastic_new_key.id
}

output "authToken" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.elastic_new_key.secret_string)["authToken"]
  sensitive = true
}

output "replicationGroupId" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.elastic_new_key.secret_string)["replicationGroupId"]
  sensitive = true
}
