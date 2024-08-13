resource "aws_cloudfront_distribution" "website_distribution" {
  origin {
    domain_name = aws_s3_bucket.static_website.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.static_website.bucket}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oid.cloudfront_access_identity_path
    }
  }

  enabled = true

  is_ipv6_enabled = true

  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id = "S3-${aws_s3_bucket.static_website.bucket}"
    viewer_protocol_policy = "redirect-to-https"

    allowed_headers {
      quantity = 1
      items    = ["*"]
    }

    allowed_methods {
      quantity = 2
      items    = ["GET", "HEAD"]
    }

    allowed_origins {
      quantity = 1
      items    = ["*"]
    }

    cached_methods {
      quantity = 2
      items    = ["GET", "HEAD"]
    }

    min_ttl = 0
    default_ttl = 86400
    max_ttl = 31536000
  }
  
  tags = {
    Name = "Static Website Distribution"
  }
}

resource "aws_cloudfront_origin_access_identity" "oid" {
  comment = "Origin Access Identity for S3 Bucket"
}

#IAM

resource "aws_iam_role" "cloudfront_role" {
  name = "cloudfront_s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "cloudfront_policy" {
  name = "cloudfront_s3_policy"
  role = aws_iam_role.cloudfront_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow",
        Resource = "${aws_s3_bucket.static_website.arn}/*"
      }
    ]
  })
}
