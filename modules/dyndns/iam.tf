data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "route53_access" {
  statement {
    actions = [
      "route53:ChangeResourceRecordSets"
    ]
    resources = ["arn:aws:route53:::hostedzone/${local.domainZoneId}"]
  }

  statement {
    actions = [
      "ssm:GetParameter"
    ]
    resources = [
      aws_ssm_parameter.creds.arn,
      "arn:aws:ssm:eu-central-1:134156946228:*"
    ]
  }

  statement {
    actions = [
      "kms:Decrypt"
    ]
    resources = [data.aws_kms_key.ssm_default.arn]
  }
}

resource "aws_iam_role" "ddns" {
  name               = "${local.santizedDomain}_ddns_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
}

resource "aws_iam_role_policy_attachment" "basic_exec" {
  role       = aws_iam_role.ddns.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "route53" {
  name   = "access"
  role   = aws_iam_role.ddns.id
  policy = data.aws_iam_policy_document.route53_access.json
}


# api gateway role
data "aws_iam_policy_document" "apigateway_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "apigateway.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "apigateway" {
  name               = "ddns_apigateway_role"
  assume_role_policy = data.aws_iam_policy_document.apigateway_assume.json
}
