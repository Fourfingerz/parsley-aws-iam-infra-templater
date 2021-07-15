variable "environment" {
  type        = string
  description = "dev, staging, prod"
  default     = "dev"
}

variable "table-name" {
  type        = string
  description = "The name of the table"
}

variable "region" {
  type        = string
  description = "The AWS region to target for deploymnet"
  default     = "us-east-1"
}

variable "principals" {
  type        = list(string)
  description = "A List of ARN roles you want to assume this role to"
  default     = []
}