variable "cloudfront_region" {
  description = "The region for CloudFront distribution"
  default     = "us-east-1"
}

variable "loadbalancer_region" {
  description = "The region for Load Balancer"
  default     = "us-west-1"
}

variable "domain_name" {
  description = "The domain name for SSL certificate"
  default     = "example.com"
}

