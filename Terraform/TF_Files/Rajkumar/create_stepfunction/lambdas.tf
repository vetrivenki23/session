# Define Lambda functions

resource "aws_lambda_function" "first_lambda" {
  function_name    = "FirstLambdaFunction"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "first_lambda.lambda_handler"
  runtime          = "python3.8"
  filename         = data.archive_file.first_lambda_zip.output_path
  source_code_hash = data.archive_file.first_lambda_zip.output_base64sha256


  depends_on = [data.archive_file.first_lambda_zip]
}

resource "aws_lambda_function" "second_lambda" {
  function_name    = "SecondLambdaFunction"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "second_lambda.lambda_handler"
  runtime          = "python3.8"
  filename         = data.archive_file.second_lambda_zip.output_path
  source_code_hash = data.archive_file.second_lambda_zip.output_base64sha256


  depends_on = [data.archive_file.second_lambda_zip]
}

data "archive_file" "first_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/first_lambda.py"
  output_path = "${path.module}/first_lambda.zip"
}

data "archive_file" "second_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/second_lambda.py"
  output_path = "${path.module}/second_lambda.zip"
}

