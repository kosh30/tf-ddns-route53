locals {
  domainZoneId   = var.domain_data.create_zone ? aws_route53_zone.this[0].zone_id : data.aws_route53_zone.zone[0].zone_id
  santizedDomain = lower(replace(var.domain_data.domain, "/[[:punct:]]/", ""))
}
