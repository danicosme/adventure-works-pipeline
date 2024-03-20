variable "sqs_role_arn"{
  description = "ARN da role da fila SQS"
}

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

data "aws_iam_policy_document" "policy_document_role_silver"{
    statement{
        effect = "Allow"
        actions = ["sqs:SendMessage","sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes"]
        resources = ["*"]
    }
}

resource "aws_iam_policy" "policy_role_silver"{
    name = "policy_role_silver"
    policy = data.aws_iam_policy_document.policy_document_role_silver.json
}

resource "aws_iam_role_policy_attachment" "role_policy_silver"{
    role = aws_iam_role.lambda_role_silver.name
    policy_arn = aws_iam_policy.policy_role_silver.arn
}


output "iam_role_arn" {
  value       = aws_iam_role.lambda_role_silver.arn
}
