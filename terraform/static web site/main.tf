provider "aws" {
  region = "us-east-1"  # Choose the AWS region you prefer
}

resource "aws_s3_bucket" "static_website" {
  bucket = "my-static-website-bucket-unique"  # Ensure this is unique
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name = "Static Website Bucket"
  }
}

resource "aws_s3_bucket_object" "website_index" {
  bucket = aws_s3_bucket.static_website.bucket
  key    = "index.html"
  source = "path/to/your/index.html"  # Path to your index.html file
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "website_error" {
  bucket = aws_s3_bucket.static_website.bucket
  key    = "error.html"
  source = "path/to/your/error.html"  # Path to your error.html file
  acl    = "public-read"
}
