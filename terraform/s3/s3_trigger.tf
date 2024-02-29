variable "sns_role_arn"{
    description = "ARN do tópico SNS"
}

data "aws_s3_bucket" "bucket_raw"{
    bucket = "adventure-works-bronze"
}

resource "aws_s3_bucket_notification" "bucket_notification"{
    bucket = data.aws_s3_bucket.bucket_raw.id

    topic{
        topic_arn = var.sns_role_arn
        events = ["s3:PutObejct:*"]
    }
}