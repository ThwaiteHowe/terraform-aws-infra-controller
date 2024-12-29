resource "aws_acm_certificate" "thwaite_root_certificate" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = [var.domain_name]

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    ManagedBy   = "Terraform"
    Project     = "Thwaitehowe"
    Environment = "Prod"
  }
}

resource "aws_route53_record" "certificate_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.thwaite_root_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id    = var.existing_zone_id
  name       = each.value.name
  type       = each.value.type
  records    = [each.value.record]
  ttl        = 60
  depends_on = [aws_acm_certificate.thwaite_root_certificate]
}

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