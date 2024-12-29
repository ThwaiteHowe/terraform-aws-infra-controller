variable "bucket_name" {
  default     = "thwaitehowe.com"
  description = "The name of the S3 bucket"
  type        = string
}

variable "domain_name" {
  default     = "thwaitehowe.com"
  description = "The domain name"
  type        = string
}

# variable "vault_token" {
#   description = "value of the vault token"
#   type        = string
#   sensitive = true
# }

variable "hcp_client_id" {
  description = "HCP client ID"
  type        = string
  sensitive   = true
}

variable "hcp_client_secret" {
  description = "HCP client secret"
  type        = string
  sensitive   = true
}

variable "vault_app_name" {
  description = "HCP Vault App Name"
  type        = string
  default     = "Terraform-Skeleton-CLI"
}