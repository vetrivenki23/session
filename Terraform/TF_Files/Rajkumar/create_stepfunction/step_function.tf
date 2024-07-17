resource "aws_sfn_state_machine" "step_function" {
  name     = "LambdaStepFunction"
  role_arn = aws_iam_role.step_functions_execution_role.arn

  definition = jsonencode({
    Comment : "A simple AWS Step Functions example to invoke two Lambda functions sequentially",
    StartAt : "InvokeFirstLambda",
    States : {
      InvokeFirstLambda : {
        Type : "Task",
        Resource : aws_lambda_function.first_lambda.arn,
        ResultPath : "$.FirstLambdaResult",
        Next : "InvokeSecondLambda"
      },
      InvokeSecondLambda : {
        Type : "Task",
        Resource : aws_lambda_function.second_lambda.arn,
        InputPath : "$.FirstLambdaResult",
        ResultPath : "$.SecondLambdaResult",
        End : true
      }
    }
  })
}
