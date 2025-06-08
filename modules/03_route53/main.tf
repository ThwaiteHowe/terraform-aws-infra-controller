resource "aws_route53_record" "cloudfront_distribution_record" {
  zone_id = var.existing_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = true
  }

}