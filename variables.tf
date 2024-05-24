variable "env" {
  type        = string
  description = "The environment of project."
  default     = "dev"
}

variable "region" {
  description = "The AWS region where resources will be created."
  default     = "us-east-1"
}

variable "profile" {
  description = "The AWS profile used to create resources."
  default     = "Prajwal"
}

variable "access_key" {
  description = "The Access Key for given profile."
}

variable "secret_key" {
  description = "The Secret Access Key for given profile."
}

variable "AMIs" {
  type        = map(string)
  description = "AMI ids for regions(April 2024)."
  default = {
    "us-east-1"  = "ami-080e1f13689e07408"
    "us-east-2"  = "ami-0b8b44ec9a8f90422"
    "us-west-1"  = "ami-05c969369880fa2c2"
    "us-west-2"  = "ami-08116b9957a259459"
    "ap-south-1" = "ami-007020fd9c84e18c7"
    "eu-west-1"  = "ami-0c1c30571d2dae5c9"
  }
}

variable "instance_type" {
  type        = map(string)
  description = "The AWS EC2 instance type as per environment."
  default = {
    "dev"     = "t3.micro"
    "staging" = "t3.small"
    "prod"    = "t3.medium"
  }
}

variable "key_pair" {
  description = "The AWS EC2 instance key pair."
  default     = "Project-Key"
}
