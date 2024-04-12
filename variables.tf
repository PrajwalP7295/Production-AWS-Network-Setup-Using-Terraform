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