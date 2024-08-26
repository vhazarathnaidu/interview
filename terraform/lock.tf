provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  region     = "us-east-1"
}

resource "aws_s3_bucket" "tf_course" {
    
    bucket = "hella-buckets"

}

terraform {
  backend "s3" {
    encrypt = true    
    bucket = "hella-buckets"
    dynamodb_table = "terraform-state-lock-dynamo"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}