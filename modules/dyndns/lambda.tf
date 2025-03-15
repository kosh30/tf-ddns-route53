variable "lambda_s3_bucket" {
  description = "S3 bucket to store the lambda code"
  type        = string
  default     = ""
}

variable "store_lambda_on_s3" {
  type        = bool
  default     = false
  description = "Store the lambda code on S3"
}

variable "lambda_s3_prefix" {
  description = "S3 prefix to store the lambda code"
  type        = string
  default     = ""
}

locals {
  store_lambda_on_s3 = var.lambda_s3_bucket != "" && var.store_lambda_on_s3 ? true : false
}

module "lambda_function" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = ">= 7"
  function_name = "${local.santizedDomain}_ddns_lambda"
  description   = "Dynamic DNS updater for ${var.domain_data.domain}"
  handler       = "index.handler"
  runtime       = "python3.12"
  publish       = true
  timeout       = 300

  source_path = "${path.module}/lambda"

  store_on_s3 = local.store_lambda_on_s3
  s3_bucket   = var.lambda_s3_bucket
  s3_prefix   = var.lambda_s3_prefix

  environment_variables = {
    HOSTED_ZONE_ID     = local.domainZoneId
    SSM_PARAMETER_NAME = "/${local.santizedDomain}_ddns_route53_credentials"
  }

  attach_policies = true
  policies = [
    aws_iam_role_policy_attachment.basic_exec.policy_arn
  ]
  number_of_policies = 1

  attach_policy_statements = true
  policy_statements = {
    route53 = {
      actions = [
        "route53:ChangeResourceRecordSets"
      ]
      resources = [local.domainZoneArn]
    }

    ssmpolicy = {
      actions = [
        "ssm:GetParameter"
      ]
      resources = [
        aws_ssm_parameter.creds.arn
      ]
    }

    kms = {
      actions = [
        "kms:Decrypt"
      ]
      resources = [
        data.aws_kms_key.ssm_default.arn
      ]
    }
  }


  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.api_execution_arn}/*/*"
    }
  }

}
