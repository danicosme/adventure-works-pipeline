terraform {
  required_providers{
    aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

provider "aws"{
    region = "us-east-1"
}


# Módulo separado por recurso
module "sqs_module"{
    source = "./sqs"
}

module "sns_module"{
    source = "./sns"
}

module "iam_module"{
    source = "./iam"
    sqs_role_arn = module.sqs_module.sqs_role_arn
}

module "sub_module"{
    source = "./subscriptions"
    sns_role_arn = module.sns_module.sns_role_arn
    sqs_role_arn = module.sqs_module.sqs_role_arn
}

module "lambda_module"{
    source = "./lambda"
    iam_role_arn = module.iam_module.iam_role_arn
}


module "triggers_module"{
    source = "./triggers"
    sns_role_arn = module.sns_module.sns_role_arn
    lambda_role_arn = module.lambda_module.lambda_role_arn
    sqs_role_arn = module.sqs_module.sqs_role_arn
}

module "cloudwatch" {
    source = "./cloudwatch"
    lambda_function_name = module.lambda_module.lambda_function_name
}