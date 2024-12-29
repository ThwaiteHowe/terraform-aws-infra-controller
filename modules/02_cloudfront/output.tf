output "distribution_domain_name" {
  value = aws_cloudfront_distribution.thwaite_s3_distribution.domain_name
}

output "cloudfront_distribution_zone_id" {
  value = aws_cloudfront_distribution.thwaite_s3_distribution.hosted_zone_id
}