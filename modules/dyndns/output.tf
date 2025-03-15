output "api_endpoint" {
  value = "${module.api_gateway.api_endpoint}/nic/update"
}

output "domain_api_endpoint" {
  value = "https://${local.apiFullDomain}/nic/update"
}

output "allowed_domain" {
  value = local.domainZoneName
}

output "username" {
  value     = local.usename
  sensitive = true
}

output "password" {
  value     = local.password
  sensitive = true
}
