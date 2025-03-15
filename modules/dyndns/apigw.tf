locals {
  apiFullDomain = "${var.domain_data.api_domain_prefix}.${var.domain_data.domain}"
}
module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = ">= 5"

  name = "${local.santizedDomain}_ddns_api_gateway"
  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  domain_name      = local.apiFullDomain
  hosted_zone_name = local.domainZoneName

  create_routes_and_integrations = true
  routes = {
    "ANY /nic/update" = {
      integration = {
        type                   = "AWS_PROXY"
        uri                    = module.lambda_function.lambda_function_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 3000
      }
    }
  }
}
