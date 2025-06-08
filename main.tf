resource "aws_route53_zone" "thwaitehowe_zone" {
  name = var.root_domain_name
  tags = {
    ManagedBy   = "Terraform"
    Project     = "Thwaitehowe"
  }
}
module "s3_bucket" {
  source      = "./modules/01_s3_bucket"
  bucket_name = var.bucket_name
  environment = var.environment
}

module "cloudfront" {
  source                      = "./modules/02_cloudfront"
  bucket_name                 = var.bucket_name
  bucket_id                   = module.s3_bucket.bucket_website_endpoint
  bucket_regional_domain_name = module.s3_bucket.bucket_regional_domain_name
  environment                 = var.environment
  root_domain_name            = var.root_domain_name
  domain_name                 = var.domain_name
  existing_zone_id            = aws_route53_zone.thwaitehowe_zone.zone_id
}

module "route53" {
  source                              = "./modules/03_route53"
  domain_name                         = var.domain_name
  cloudfront_distribution_domain_name = module.cloudfront.distribution_domain_name
  cloudfront_distribution_zone_id     = module.cloudfront.cloudfront_distribution_zone_id
  existing_zone_id                    = aws_route53_zone.thwaitehowe_zone.zone_id
}

