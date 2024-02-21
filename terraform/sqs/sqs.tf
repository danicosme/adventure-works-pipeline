resource "aws_sqs_queue" "sqs_raw_silver"{
    name = "sqs-raw-silver-aw"
    message_retention_seconds = 86400
    receive_wait_time_seconds = 5
    redrive_policy = jsonencode({
        deadLetterTargetArn = aws_sqs_queue.sqs_dlq_raw_silver.arn
        maxReceiveCount = 4
    })
}

resource "aws_sqs_queue" "sqs_dlq_raw_silver"{
    name = "sqs-dlq-raw-silver-aw"
}