output "lambda_function_arn" {
  value = aws_lambda_function.elastic_new_auth_key_updater.arn
}

output "secretsmanager_secret_arn" {
  value = aws_secretsmanager_secret.elastic_new_auth_key.arn
}
