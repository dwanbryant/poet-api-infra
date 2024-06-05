resource "aws_s3_bucket" "terraform_state" {
  bucket = "poet-api-infra-bryant"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "terraform-state-lifecycle"
    enabled = true

    noncurrent_version_expiration {
      days = 30
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
