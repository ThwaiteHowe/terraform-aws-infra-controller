resource "aws_cloudfront_origin_access_control" "thwaite_s3_oac" {
  name                              = "thwaitehowe-s3-oac"
  description                       = "OAC for S3 origin"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_origin_access_identity" "thwaite_distribution_oai" {
  comment = "OAI for Thwaitehowe"
}

resource "aws_cloudfront_distribution" "thwaite_s3_distribution" {
  aliases             = ["thwaitehowe.com"]
  retain_on_delete    = false
  wait_for_deployment = false

  default_cache_behavior {
    # fetch s3 bucket id and pass it to this field
    target_origin_id = var.bucket_id

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"

  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  origin {
    # fetch s3 bucket name and pass it to this field
    domain_name = var.bucket_regional_domain_name
    origin_id   = var.bucket_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.thwaite_distribution_oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CDN for Thwaitehowe"
  default_root_object = "index.html"
  price_class         = "PriceClass_All"

  viewer_certificate {
    acm_certificate_arn = data.aws_acm_certificate.thwaite_root_certificate.arn
    ssl_support_method  = "sni-only"
  }

  tags = {
    ManagedBy   = "Terraform"
    Project     = "Thwaitehowe"
    Environment = "Prod"
  }
}

data "aws_acm_certificate" "thwaite_root_certificate" {
  domain    = var.bucket_name
  statuses  = ["ISSUED"]
  types     = ["AMAZON_ISSUED"]
  key_types = ["RSA_2048"]
}