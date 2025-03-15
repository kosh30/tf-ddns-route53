data "aws_route53_zone" "zone" {
  count = var.domain_data.create_r53_zone ? 0 : 1
  name  = var.domain_data.domain
}
