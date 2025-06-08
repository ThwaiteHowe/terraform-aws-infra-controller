variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "domain_name" {
  description = "The domain name"
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

variable "environment" {
  description = "The environment"
  type        = string
}

variable "root_domain_name" {
  description = "The root domain name"
  type        = string
}

variable "existing_zone_id" {
  description = "The existing zone id"
  type        = string
}