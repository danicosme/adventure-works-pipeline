data "aws_iam_policy_document" "assume_role"{
    statement{
        effect = "Allow"

        principals{
            type        = "Service"
            identifiers = ["lambda.amazonaws.com"]
        }

        actions = ["sts:AssumeRole"]

    }
}

resource "aws_iam_role" "lambda_role_silver"{
    name = "lambda_role_silver"
    assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

output "iam_role_arn" {
  value       = aws_iam_role.lambda_role_silver.arn
}
