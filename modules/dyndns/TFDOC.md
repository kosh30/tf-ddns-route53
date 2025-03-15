# dyndns

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.90.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | terraform-aws-modules/apigateway-v2/aws | >= 5 |
| <a name="module_lambda_function"></a> [lambda\_function](#module\_lambda\_function) | terraform-aws-modules/lambda/aws | >= 7 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.apigateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ddns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.route53](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.basic_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_ssm_parameter.creds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.apigateway_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.route53_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.ssm_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_data"></a> [domain\_data](#input\_domain\_data) | The domain data to be used for the dynamic DNS update | <pre>object({<br/>    domain            = string<br/>    create_r53_zone   = optional(bool, false) // Create a new Route53 zone<br/>    api_domain_prefix = optional(string, "ddns")<br/>  })</pre> | n/a | yes |
| <a name="input_domain_secrets"></a> [domain\_secrets](#input\_domain\_secrets) | The domain secrets to be used for the dynamic DNS update | <pre>object({<br/>    username = optional(string, "ddns")<br/>    password = optional(string, "")<br/>  })</pre> | n/a | yes |
| <a name="input_lambda_s3_bucket"></a> [lambda\_s3\_bucket](#input\_lambda\_s3\_bucket) | S3 bucket to store the lambda code | `string` | `""` | no |
| <a name="input_lambda_s3_prefix"></a> [lambda\_s3\_prefix](#input\_lambda\_s3\_prefix) | S3 prefix to store the lambda code | `string` | `""` | no |
| <a name="input_store_lambda_on_s3"></a> [store\_lambda\_on\_s3](#input\_store\_lambda\_on\_s3) | Store the lambda code on S3 | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allowed_domain"></a> [allowed\_domain](#output\_allowed\_domain) | n/a |
| <a name="output_api_endpoint"></a> [api\_endpoint](#output\_api\_endpoint) | n/a |
| <a name="output_domain_api_endpoint"></a> [domain\_api\_endpoint](#output\_domain\_api\_endpoint) | n/a |
| <a name="output_password"></a> [password](#output\_password) | n/a |
| <a name="output_username"></a> [username](#output\_username) | n/a |
<!-- END_TF_DOCS -->
