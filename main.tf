#https://github.com/nckslvrmn/unifi_ddns_route53.git
data "sops_file" "secrets" {
  source_file = "${path.module}/secrets-encrypted.yaml"
}
locals {
  secrets = yamldecode(data.sops_file.secrets.raw)
  domains = [for k, v in local.secrets : {
    domain   = k
    username = v.username
    password = v.password
  }]
}

module "domains" {
  source   = "./modules/dyndns"
  for_each = nonsensitive(local.secrets)
  domain_data = {
    domain = each.key
  }
  domain_secrets = {
    username = each.value.username
    password = each.value.password
  }
  lambda_s3_bucket   = "serverless-svelte-kosh-deploys"
  lambda_s3_prefix   = "ddns-route53/lambda/"
  store_lambda_on_s3 = true
}

output "ddns_settings" {
  sensitive = false
  value = { for k, v in module.domains : k => {
    domain          = k
    api_endpoint    = v.api_endpoint
    domain_endpoint = v.domain_api_endpoint
    allowedDomains  = v.allowed_domain
    example_curl    = "curl -u 'username:xxxxxx' '${v.domain_api_endpoint}?hostname=example.${v.allowed_domain}&myip=192.168.0.1'"
  } }
}

output "secrets" {
  value = { for k, v in module.domains : k => {
    domain          = k
    api_endpoint    = v.api_endpoint
    domain_endpoint = v.domain_api_endpoint
    allowedDomains  = v.allowed_domain
    username        = v.username
    password        = v.password
    example_curl    = "curl -u '${v.username}:${v.password}' '${v.domain_api_endpoint}?hostname=example.${v.allowed_domain}&myip=192.168.0.1'"
  } }
  sensitive = true
}
