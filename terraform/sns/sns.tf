data "aws_iam_policy_document" "topic_arn" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["SNS:Publish"]
    resources = ["*"]
  }
}

resource "aws_sns_topic" "sns_raw_silver"{
    name = "sns-raw-silver-aw"
    policy = data.aws_iam_policy_document.topic_arn.json
}

output "sns_role_arn"{
    value = aws_sns_topic.sns_raw_silver.arn
}