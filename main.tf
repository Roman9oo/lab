provider "aws" {
  region = "eu-central-1"
}

module "label" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.25.0"
  namespace = var.namespace
  stage     = var.stage
  name      = var.name
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${module.label.id}-terraform-tfstate"
  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${module.label.id}-tfstate-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
