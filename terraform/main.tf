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
module "iam_module"{
    source = "./iam"
}

module "sns_module"{
    source = "./sns"
}

module "sqs_module"{
    source = "./sqs"
}

module "sns_sub"{
    source = "./sns"
}

# module "s3_trigger"{
#     source = "./s3"
#     sns_role_arn = module.sns_module.sns_role_arn
# }

module "lambda_module"{
    source = "./lambda"
    iam_role_arn = module.iam_module.iam_role_arn
}
