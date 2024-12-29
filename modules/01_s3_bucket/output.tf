output "bucket_website_endpoint" {
  value = aws_s3_bucket_website_configuration.thwaite_s3_website.website_endpoint
}
output "bucket_regional_domain_name" {
  value = aws_s3_bucket.thwaite_s3.bucket_regional_domain_name
}