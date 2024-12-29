variable "domain_name" {
  description = "The domain name"
  type        = string
}

variable "cloudfront_distribution_domain_name" {
  description = "The cloudfront distribution name"
  type        = string
}

variable "cloudfront_distribution_zone_id" {
  description = "The cloudfront distribution ID"
  type        = string
}

variable "existing_zone_id" {
  description = "The existing zone id"
  type        = string
}