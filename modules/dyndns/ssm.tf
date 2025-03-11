data "aws_kms_key" "ssm_default" {
  key_id = "alias/aws/ssm"
}

resource "aws_ssm_parameter" "creds" {
  name   = "/${local.santizedDomain}_ddns_route53_credentials"
  type   = "SecureString"
  value  = "${var.domain_data.username}:${var.domain_data.password}"
  key_id = data.aws_kms_key.ssm_default.key_id

  lifecycle {
    ignore_changes = [value]
  }
}
