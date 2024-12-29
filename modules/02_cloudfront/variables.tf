variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  type        = string
}

variable "bucket_id" {
  description = "The ID of the S3 bucket"
  type        = string
}

variable "bucket_regional_domain_name" {
  type        = string
  description = "value of the regional domain name of the S3 bucket"
}