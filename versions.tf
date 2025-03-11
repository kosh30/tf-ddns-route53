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
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = ">= 5.0"
    # }
    # local = {
    #   source  = "hashicorp/local"
    #   version = ">= 2.0"
    # }
    # random = {
    #   source  = "hashicorp/random"
    #   version = ">= 3.0"
    # }
    #
    # tls = {
    #   source  = "hashicorp/tls"
    #   version = ">= 4.0"
    # }
    sops = {
      source  = "carlpett/sops"
      version = ">= 1"
    }

  }
}
