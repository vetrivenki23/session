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

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

# Create subnets
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "subnet-a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "subnet-b"
  }
}

# Create a security group
resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

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

  tags = {
    Name = "main-security-group"
  }
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_rotation_role" {
  name = "lambda_rotation_role_new" # Change the role name to avoid conflict

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
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

# Lambda function for rotating the secret
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

resource "aws_lambda_permission" "allow_secretsmanager" {
  statement_id  = "AllowExecutionFromSecretsManager"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rotation_lambda.function_name
  principal     = "secretsmanager.amazonaws.com"
  source_arn    = aws_secretsmanager_secret.my_new_secret.arn
}

# Secrets Manager resources
resource "aws_secretsmanager_secret" "my_new_secret" {
  name = "my_elasticnew_secret"
}

resource "aws_secretsmanager_secret_version" "my_new_secret_version" {
  secret_id     = aws_secretsmanager_secret.my_new_secret.id
  secret_string = "your-initial-token" # Replace with your initial token or use a generated one
}

# ElastiCache replication group
resource "aws_elasticache_replication_group" "redis_replication_group" {
  replication_group_id       = "my-replication-group"
  description                = "Replication group for my Redis cluster"
  node_type                  = "cache.t2.micro"
  num_cache_clusters         = 2
  automatic_failover_enabled = true
  engine_version             = "6.x"
  auth_token                 = aws_secretsmanager_secret_version.my_new_secret_version.secret_string
  transit_encryption_enabled = true

  subnet_group_name  = aws_elasticache_subnet_group.elasticache_subnet_group.name
  security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "my-elasticache-redis"
  }

  lifecycle {
    ignore_changes = [
      parameter_group_name
    ]
  }
}

# ElastiCache subnet group
resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name       = "elasticache-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  tags = {
    Name = "elasticache-subnet-group"
  }
}

output "redis_endpoint" {
  value = aws_elasticache_replication_group.redis_replication_group.primary_endpoint_address
}
