data "aws_route53_zone" "zone" {
  count        = var.domain_data.create_zone ? 0 : 1
  private_zone = var.domain_data.private_zone
  name         = var.domain_data.domain
}
