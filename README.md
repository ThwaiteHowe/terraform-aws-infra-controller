# Initialize Terraform and import the zone:
terraform init
terraform import module.route53.aws_route53_zone.main ZONE_ID
