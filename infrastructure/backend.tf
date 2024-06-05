terraform {
  backend "s3" {
    bucket         = "poet-api-infra-bryant"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}
