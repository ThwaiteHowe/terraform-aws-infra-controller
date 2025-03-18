terraform {
  cloud {
    organization = "Thwaitehowe"

    workspaces {
      name = "skeleton-prod"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }

    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.101.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  access_key                  = local.aws_access_key_id
  secret_key                  = local.aws_secret_access_key
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}

