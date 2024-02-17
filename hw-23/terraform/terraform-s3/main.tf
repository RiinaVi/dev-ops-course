provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "state_bucket" {
  bucket = "rd-state-bucket-arina"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encrypt" {
  bucket = aws_s3_bucket.state_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "dynamodb_lock" {
  name = "state-lock-1"
  read_capacity = 1
  write_capacity = 1
  billing_mode = "PROVISIONED"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "TF Lock Table"
    Env = "test"
  }
}

