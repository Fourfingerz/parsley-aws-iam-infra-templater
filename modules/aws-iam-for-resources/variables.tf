variable "principals" {
  type        = list(string)
  description = "Map of service name as key and a list of ARNs to allow assuming the role as value (e.g. map(`AWS`, list(`arn:aws:iam:::role/admin`)))"
  default     = []
}

variable "name" {
  type = string
}

variable "role_description" {
  type        = string
  description = "The description of the IAM role that is visible in the IAM role manager"
}

variable "policy_description" {
  type        = string
  description = "The description of the IAM policy that is visible in the IAM policy manager"
}

variable "policy_documents" {
  type        = list(string)
  description = "List of IAM Policy JSONs"
  default     = []
}

variable "tags" {
  type = map
}