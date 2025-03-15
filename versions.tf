terraform {
  required_version = ">= 1"
  backend "s3" {
    bucket         = "serverless-svelte-kosh-deploys"
    key            = "ddns-route53/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }

  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = ">= 1"
    }

  }
}
