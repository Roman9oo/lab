terraform {
  backend "s3" {
    bucket         = "761160581043-terraform-tfstate"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-tfstate-lock"
    encrypt        = true
  }
}

