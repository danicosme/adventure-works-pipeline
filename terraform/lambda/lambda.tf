variable "iam_role_arn" {
  description = "ARN da role que fará a execução da Lambda"
}

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

    # Pacotes
    layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python39:18", "arn:aws:lambda:us-east-1:521796944127:layer:Loguru:1"]
}

output "lambda_role_arn"{
    value = aws_lambda_function.lambda_silver.arn
}