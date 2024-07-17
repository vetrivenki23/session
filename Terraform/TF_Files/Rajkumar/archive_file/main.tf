# Archive a single file.

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
