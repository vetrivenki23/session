provider "aws" {
  region = "us-east-2"
}

variable "kms_key_arn" {
  description = "ARN of the existing KMS key"
  default     = "arn:aws:kms:us-east-2:357674677184:key/36040458-8306-4bc1-9dc7-fa07b74abeae" # Update with your actual KMS key ARN
}

resource "aws_secretsmanager_secret" "elastic_new_auth_key" {
  name       = "elastic_new_auth_key"
  kms_key_id = var.kms_key_arn
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })

  inline_policy {
    name = "secretsmanager_policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "secretsmanager:PutSecretValue",
            "secretsmanager:GetSecretValue",
            "secretsmanager:UpdateSecret",
            "secretsmanager:DescribeSecret",
            "secretsmanager:RotateSecret"
          ]
          Resource = aws_secretsmanager_secret.elastic_new_auth_key.arn
        },
        {
          Effect = "Allow"
          Action = [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:DescribeKey"
          ]
          Resource = var.kms_key_arn
        },
        {
          Effect   = "Allow"
          Action   = "lambda:InvokeFunction"
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_lambda_function" "elastic_new_auth_key_updater" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "elastic_new_auth_key_updater"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  environment {
    variables = {
      SECRET_NAME = "elastic_new_auth_key"
    }
  }
}

resource "aws_cloudwatch_event_rule" "every_4_hours" {
  name                = "every_4_hours"
  schedule_expression = "rate(4 hours)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.every_4_hours.name
  target_id = "lambda_target"
  arn       = aws_lambda_function.elastic_new_auth_key_updater.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.elastic_new_auth_key_updater.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_4_hours.arn
}

resource "aws_lambda_permission" "allow_secretsmanager" {
  statement_id  = "AllowExecutionFromSecretsManager"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.elastic_new_auth_key_updater.function_name
  principal     = "secretsmanager.amazonaws.com"
  source_arn    = aws_secretsmanager_secret.elastic_new_auth_key.arn
}

resource "aws_secretsmanager_secret_rotation" "elastic_new_authtoken" {
  secret_id           = aws_secretsmanager_secret.elastic_new_auth_key.id
  rotation_lambda_arn = aws_lambda_function.elastic_new_auth_key_updater.arn
  rotation_rules {
    automatically_after_days = 1
  }
}
