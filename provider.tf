terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Thwaitehowe"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  secret_key = var.AWS_SECRET_ACCESS_KEY
  access_key = var.AWS_ACCESS_KEY_ID
}