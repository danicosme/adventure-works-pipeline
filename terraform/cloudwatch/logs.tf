variable "lambda_function_name" {
  description = "Nome da função lambda silver"
}

resource "aws_cloudwatch_log_group" "log_lambda" {
    name = "/aws/lambda/${var.lambda_function_name}"
    retention_in_days = 1
}