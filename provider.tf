terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.44.0"
    }
  }
}

provider "aws" {
  region  = var.region            # AWS_Region
  profile = var.profile           # AWS_IAM_Username
  access_key = var.access_key     # IAM_User_Access_Key
  secret_key = var.secret_key     # IAM_User_Secret_Access_Key
}
