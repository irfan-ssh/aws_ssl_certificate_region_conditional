resource "aws_cloudfront_distribution" "my_distribution" {
  provider = aws.us_east_1
  origin {
    domain_name = aws_s3_bucket.rag_s3_chatbot.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.rag_s3_chatbot.bucket_regional_domain_name
  }
  
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "My CloudFront Distribution"
    
  viewer_certificate {
    acm_certificate_arn            = local.cloudfront_cert_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.rag_s3_chatbot.bucket_regional_domain_name
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
}
