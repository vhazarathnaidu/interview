

resource "aws_s3_bucket" "bucket-local-name" {
  bucket = "my-tf-test-bucket2"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

  resource "aws_s3_bucket_acl" "bucket-local-name-acl" {
  bucket = aws_s3_bucket.bucket-local-name.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket-local-name-versioning" {
  bucket = aws_s3_bucket.bucket-local-name.id
  versioning_configuration {
    status = "Enabled"
  }
}