# MODULE: BASE IAM ROLE
data "aws_iam_policy_document" "sts_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:assumeRole"]

    principals {
      type = "AWS" 
      identifiers = var.principals
    }
  }
}

data "aws_iam_policy_document" "sts_assume_override" {
  override_policy_documents = data.aws_iam_policy_document.sts_assume.*.json
}

resource "aws_iam_role" "default" {
  name               = var.name
  assume_role_policy = join("", data.aws_iam_policy_document.sts_assume_override.*.json)
  description        = var.role_description
  tags               = var.tags
}

data "aws_iam_policy_document" "default" {
  override_policy_documents = var.policy_documents
}

resource "aws_iam_policy" "default" {
  name        = "${var.name}_iam_policy"
  description = var.policy_description 
  policy      = join("", data.aws_iam_policy_document.default.*.json)
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = join("", aws_iam_role.default.*.name)
  policy_arn = join("", aws_iam_policy.default.*.arn)
}