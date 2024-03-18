variable "sqs_role_arn"{
  description = "ARN da role da fila SQS"
}

variable "sns_role_arn"{
  description = "ARN da role do tópico SNS"
}

resource "aws_sns_topic_subscription" "sns_sqs_sub"{
    topic_arn   = var.sns_role_arn
    protocol    = "sqs"
    endpoint    = var.sqs_role_arn
}