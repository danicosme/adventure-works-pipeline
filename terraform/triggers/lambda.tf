variable "lambda_role_arn" {
  description = "ARN da Lambda"
}

variable "sqs_role_arn"{
  description = "ARN da role da fila SQS"
}

resource "aws_lambda_event_source_mapping" "trigger"{
  event_source_arn = var.sqs_role_arn
  function_name = var.lambda_role_arn
}

