provider "aws" {
  region = "us-west-2" # Adjust the region as needed
}
/*
resource "aws_iam_role" "lambda_rotation_role" {
  name = "lambda_rotation_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_rotation_policy" {
  name        = "lambda_rotation_policy"
  description = "Policy for Lambda rotation function"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:UpdateSecretVersionStage",
          "secretsmanager:PutSecretValue"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "elasticache:ModifyReplicationGroup",
          "elasticache:DescribeReplicationGroups"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_rotation_policy_attachment" {
  role       = aws_iam_role.lambda_rotation_role.name
  policy_arn = aws_iam_policy.lambda_rotation_policy.arn
}

resource "aws_lambda_function" "rotation_function" {
  function_name = "rotation_function"
  role          = aws_iam_role.lambda_rotation_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  # Local path to your Lambda function zip file
  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  environment {
    variables = {
      # Add environment variables if needed
    }
  }
}

resource "aws_lambda_permission" "allow_secrets_manager" {
  statement_id  = "AllowExecutionFromSecretsManager"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rotation_function.function_name
  principal     = "secretsmanager.amazonaws.com"
}

resource "aws_secretsmanager_secret" "tech_secret" {
  name = "tech_secret"
}

resource "aws_secretsmanager_secret_version" "tech_secret_version" {
  secret_id = aws_secretsmanager_secret.tech_secret.id
  secret_string = jsonencode({
    username = "tech_user",
    password = "InitialAuthToken123!" # A valid initial auth token
  })
}

resource "aws_secretsmanager_secret_rotation" "tech_rotation" {
  secret_id           = aws_secretsmanager_secret.tech_secret.id
  rotation_lambda_arn = aws_lambda_function.rotation_function.arn
  rotation_rules {
    schedule_expression = "rate(1 hour)"
  }
}

data "aws_secretsmanager_secret_version" "tech_secret_version" {
  secret_id = aws_secretsmanager_secret.tech_secret.id
}

resource "aws_elasticache_replication_group" "tech" {
  replication_group_id    = "tech"
  description             = "Tech replication group"
  node_type               = "cache.t2.micro"
  num_node_groups         = 2
  replicas_per_node_group = 1
  engine                  = "redis"
  engine_version          = "6.x"
  parameter_group_name    = "default.redis6.x"

  auth_token = jsondecode(data.aws_secretsmanager_secret_version.tech_secret_version.secret_string)["password"]

  automatic_failover_enabled = true
  apply_immediately          = true
  maintenance_window         = "sun:05:00-sun:09:00"
  snapshot_retention_limit   = 7
  snapshot_window            = "07:00-09:00"
}

output "auth_token" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.tech_secret_version.secret_string)["password"]
  sensitive = true
}
*/

// create lamda function only

resource "aws_iam_role" "lambda_role" {
  name = "lambda-ex"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid    = "",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_policy_attach" {
  name       = "lambda_policy_attach"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "my_lambda_function" {
  filename         = "${path.module}/function.zip"
  function_name    = "myLambdaFunction"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("${path.module}/function.zip")
  runtime          = "python3.8"

  environment {
    variables = {
      SECRETS_MANAGER_ENDPOINT = "https://secretsmanager.us-east-1.amazonaws.com"
      SECRET_ARN               = "arn:aws:secretsmanager:us-east-1:123456789012:secret:mysecret"
      USER_NAME                = "elasticache-user"
    }
  }
}

resource "aws_lambda_permission" "allow_invoke" {
  statement_id  = "AllowExecutionFromConsole"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda_function.function_name
  principal     = "*"
}

resource "null_resource" "invoke_lambda" {
  provisioner "local-exec" {
    command = <<EOT
      aws lambda invoke \
        --function-name ${aws_lambda_function.my_lambda_function.function_name} \
        --payload '{\"SecretId\":\"arn:aws:secretsmanager:us-east-1:123456789012:secret:mysecret\",\"ClientRequestToken\":\"EXAMPLE1-90ab-cdef-fedc-ba987SECRET1\",\"Step\":\"createSecret\"}' \
        response.json && \
      echo "Lambda invoke response:" && \
      cat response.json
    EOT
  }

  depends_on = [aws_lambda_function.my_lambda_function]
}
