resource "random_password" "this" {
  length  = 12
  special = false
  numeric = true
  upper   = true
  lower   = true
}

locals {
  domainZoneArn  = var.domain_data.create_r53_zone ? aws_route53_zone.this[0].arn : data.aws_route53_zone.zone[0].arn
  domainZoneId   = var.domain_data.create_r53_zone ? aws_route53_zone.this[0].zone_id : data.aws_route53_zone.zone[0].zone_id
  domainZoneName = var.domain_data.create_r53_zone ? aws_route53_zone.this[0].name : data.aws_route53_zone.zone[0].name
  santizedDomain = lower(replace(var.domain_data.domain, "/[[:punct:]]/", ""))

  usename  = var.domain_secrets.username != "" ? var.domain_secrets.username : "ddns"
  password = var.domain_secrets.password != "" ? var.domain_secrets.password : random_password.this.result
}
