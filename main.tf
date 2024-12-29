data "hcp_vault_secrets_secret" "aws_access_key_id" {
  app_name    = var.vault_app_name
  secret_name = "AWS_ACCESS_KEY_ID"
}

data "hcp_vault_secrets_secret" "aws_secret_access_key" {
  app_name    = var.vault_app_name
  secret_name = "AWS_SECRET_ACCESS_KEY"
}

locals {
  aws_access_key_id     = data.hcp_vault_secrets_secret.aws_access_key_id.secret_value
  aws_secret_access_key = data.hcp_vault_secrets_secret.aws_secret_access_key.secret_value
}

module "s3_bucket" {
  source      = "./modules/01_s3_bucket"
  bucket_name = var.bucket_name
}

module "cloudfront" {
  source                      = "./modules/02_cloudfront"
  bucket_name                 = var.bucket_name
  acm_certificate_arn         = module.route53.acm_certificate_arn
  bucket_id                   = module.s3_bucket.bucket_website_endpoint
  bucket_regional_domain_name = module.s3_bucket.bucket_regional_domain_name
}

resource "aws_route53_zone" "thwaitehowe_zone" {
  name = var.domain_name
  tags = {
    ManagedBy   = "Terraform"
    Project     = "Thwaitehowe"
    Environment = "Prod"
  }
}

module "route53" {
  source                              = "./modules/03_route53"
  domain_name                         = var.domain_name
  cloudfront_distribution_domain_name = module.cloudfront.distribution_domain_name
  cloudfront_distribution_zone_id     = module.cloudfront.cloudfront_distribution_zone_id
  existing_zone_id                    = aws_route53_zone.thwaitehowe_zone.zone_id
}

