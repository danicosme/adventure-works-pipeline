data "aws_sns_topic" "sns_raw_silver_sub"{
    name = "sns-raw-silver-aw"
}

data "aws_sqs_queue" "sqs_raw_silver_sub"{
    name = "sqs-raw-silver-aw"
}

resource "aws_sns_topic_subscription" "sns_sqs_sub"{
    topic_arn   = aws_sns_topic.sns_raw_silver.arn
    protocol    = "sqs"
    endpoint    = data.aws_sqs_queue.sqs_raw_silver_sub.arn
}