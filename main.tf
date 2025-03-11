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
    domain   = each.key
    username = each.value.username
    password = each.value.password
  }
  lambda_s3_bucket   = "serverless-svelte-kosh-deploys"
  lambda_s3_prefix   = "ddns-route53/lambda/"
  store_lambda_on_s3 = true
}
