variable "iam_role_arn" {
  description = "ARN da role que fará a execução da Lambda"
}

# variable "sqs_role_arn"{
#   description = "ARN da role da fila SQS"
# }

resource "aws_lambda_function" "lambda_silver"{
    # Configurações da lambda
    function_name       = "lambda-silver-aw"
    handler             = "main.lambda_handler"
    runtime             = "python3.9"
    timeout             = 300
    memory_size         = 500
    role                = var.iam_role_arn

    # Código python
    filename            = "../adventure_works/lambda_function_payload.zip"
    source_code_hash    = filebase64("../adventure_works/lambda_function_payload.zip")
}

# resource "aws_lambda_event_source_mapping" "trigger"{
#   event_source_arn = var.sqs_role_arn
#   function_name = aws_lambda_function.lambda_silver.arn
# }

output "lambda_role_arn"{
    value = aws_lambda_function.lambda_silver.arn
}