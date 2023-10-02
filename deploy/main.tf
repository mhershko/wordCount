provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "python-words-count-app-tf-state"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}

data "aws_caller_identity" "current" {}