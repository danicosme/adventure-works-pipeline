# terraform{
#     required_providers {
#       aws = {
#         source = "hashicorp/aws"
#         version = "~>3.0"
#       }
#     }
# }

# provider "aws"{
#     region = "us-east-1"
# }

# # IAM
# data "aws_iam_policy_document" "assume_role"{
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["lambda.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "lambda_role_silver"{
#     name = "lambda_role_silver"
#     assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# # Lambda
# resource "aws_lambda_function" "lambda_silver"{
#     filename            = "lambda_function_payload.zip"
#     source_code_hash    = filebase64("lambda_function_payload.zip")
#     function_name       = "lambda-silver-raw"
#     role                = aws_iam_role.lambda_role_silver.arn
#     handler             = "main.lambda_handler"
#     runtime             = "python3.9"
#     timeout             = 300
#     memory_size         = 500
# }