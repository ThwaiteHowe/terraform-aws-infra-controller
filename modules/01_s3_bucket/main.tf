resource "aws_s3_bucket" "thwaite_s3" {

  bucket = var.bucket_name

  tags = {
    ManagedBy   = "Terraform"
    Project     = "Thwaitehowe"
    Environment = upper(var.environment)
  }
}

resource "aws_s3_bucket_website_configuration" "thwaite_s3_website" {
  bucket = aws_s3_bucket.thwaite_s3.id
  index_document {
    suffix = var.maintenance_mode ? "maintenance.html" : "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "thwaite_s3_public_access_block" {
  bucket                  = aws_s3_bucket.thwaite_s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_public_get_access" {
  bucket     = aws_s3_bucket.thwaite_s3.id
  policy     = file("${path.root}/templates/s3_bucket_${var.environment}_policy.json")
  depends_on = [aws_s3_bucket_public_access_block.thwaite_s3_public_access_block]
}
