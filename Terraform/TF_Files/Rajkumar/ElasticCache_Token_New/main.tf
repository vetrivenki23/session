terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_role" "lambda_rotation_role" {
  name = "lambda_rotation_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })

  # Attach AWSLambdaBasicExecutionRole managed policy
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

resource "aws_iam_role_policy" "lambda_rotation_policy" {
  name = "lambda_rotation_policy"
  role = aws_iam_role.lambda_rotation_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:PutSecretValue",
          "secretsmanager:GetSecretValue"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function" "rotation_lambda" {
  filename         = "rotation_lambda_function.zip"
  function_name    = "rotation_lambda"
  role             = aws_iam_role.lambda_rotation_role.arn
  handler          = "rotation_lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("rotation_lambda_function.zip")
  runtime          = "python3.8"

  # Enable logging
  tracing_config {
    mode = "Active"
  }

  # Optionally, set up CloudWatch Logs
  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }
}

resource "aws_secretsmanager_secret" "my_secret" {
  name = "my_secret"
}

resource "aws_lambda_permission" "allow_secretsmanager" {
  statement_id  = "AllowExecutionFromSecretsManager"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rotation_lambda.function_name
  principal     = "secretsmanager.amazonaws.com"
  source_arn    = aws_secretsmanager_secret.my_secret.arn
}
