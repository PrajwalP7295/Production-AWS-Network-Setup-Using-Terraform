terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.44.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
  access_key = var.access_key
  secret_key = var.secret_key
}
