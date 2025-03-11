
resource "aws_route53_zone" "this" {
  count = var.domain_data.create_zone ? 1 : 0
  name  = var.domain_data.domain
}
