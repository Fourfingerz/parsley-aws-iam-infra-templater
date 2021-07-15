resource "aws_iam_role" "default" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.default
  description        = var.role_description
  tags               = var.tags
}