terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>2.70.0"
    }
  }
  backend "s3" {
    bucket = "my-s3-bucket-tfstate"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}