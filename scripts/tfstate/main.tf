locals {
  # Default tags to be applied to all compatible resources
  default_tags = {
    "CreatedBy" = "Terraform",
  }

  aws_profile = "dev"
  aws_region = "ap-southeast-1"
  organization = "your_company"
  account_name = "dev"

}

resource "aws_kms_key" "key" {
  description = "s3 backend key"
  deletion_window_in_days = 7
}

resource "aws_s3_bucket" "state-bucket" {
  bucket         = "${local.organization}-terraform-state-${local.account_name}-${local.aws_region}"
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  bucket = aws_s3_bucket.state-bucket.bucket
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.state-bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_dynamodb_table" "state-lock" {
  hash_key = "LockID"
  name     = "${local.organization}-tfstate-lock-${local.account_name}-${local.aws_region}"
  write_capacity = 5
  read_capacity = 5
  attribute {
    name = "LockID"
    type = "S"
  }
}