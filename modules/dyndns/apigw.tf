module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = ">= 5"

  name = "${local.santizedDomain}_ddns_api_gateway"
  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  create_domain_records = true
  create_certificate    = true
  create_domain_name    = true
  domain_name           = "ddns.${nonsensitive(var.domain_data.domain)}"
  hosted_zone_name      = nonsensitive(var.domain_data.domain)

  create_routes_and_integrations = true
  routes = {
    "ANY /nic/update" = {
      integration = {
        type                   = "AWS_PROXY"
        uri                    = module.lambda_function.lambda_function_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 10000
      }
    }
    # "$default" = {
    #   integration = {
    #     uri = module.lambda_function.lambda_function_arn
    #     tls_config = {
    #       server_name_to_verify = var.domain_data.domain
    #     }
    #
    #     response_parameters = [
    #       {
    #         status_code = 500
    #         mappings = {
    #           "append:header.header1" = "$context.requestId"
    #           "overwrite:statuscode"  = "403"
    #         }
    #       },
    #       {
    #         status_code = 404
    #         mappings = {
    #           "append:header.error" = "$stageVariables.environmentId"
    #         }
    #       }
    #     ]
    #   }
    # }
  }
}
