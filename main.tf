
locals {
  create_single_certificate = var.cloudfront_region == var.loadbalancer_region
}

resource "aws_acm_certificate" "common_cert" {
  count      = local.create_single_certificate ? 1 : 0
  domain_name = var.domain_name
  validation_method = "DNS"
}

resource "aws_acm_certificate" "cloudfront_cert" {
  count      = local.create_single_certificate ? 0 : 1
  provider   = aws.us_east_1
  domain_name = var.domain_name
  validation_method = "DNS"
}

resource "aws_acm_certificate" "loadbalancer_cert" {
  count      = local.create_single_certificate ? 0 : 1
  provider   = aws.us_west_1
  domain_name = var.domain_name
  validation_method = "DNS"
}

locals {
  cloudfront_cert_arn = local.create_single_certificate ? aws_acm_certificate.common_cert[0].arn : aws_acm_certificate.cloudfront_cert[0].arn
  loadbalancer_cert_arn = local.create_single_certificate ? aws_acm_certificate.common_cert[0].arn : aws_acm_certificate.loadbalancer_cert[0].arn
}

