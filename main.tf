resource "aws_dynamodb_table" "parsley" {
  name           = var.table-name
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "ParsleyId"
  range_key      = "Parsley-1"

  # Keep track of each row, needs a partition ID
  attribute {
    name = "ParsleyId"
    type = "N"
  }

  attribute {
    name = "Parsley-1"
    type = "S"
  }

  attribute {
    name = "Parsley-2"
    type = "N"
  }

  global_secondary_index {
    name               = "Parsley-1-Index"
    hash_key           = "Parsley-1"
    range_key          = "Parsley-2"
    write_capacity     = 1 
    read_capacity      = 1
    projection_type    = "INCLUDE"
    non_key_attributes = ["ParsleyId"]
  }

  tags = {
    Name        = "${var.table-name}-${var.environment}"
    Environment = var.environment
  }
}

# IAM ROLES MODULE FOR ACCESS CONTROL
module "develop_role" {
  source = "./modules/aws-iam-for-resources"
  name = "dynamodb_access_for_developers"

  policy_description = "Allow DynamoDB read write access"
  role_description = "IAM role that allows RW access to DynamoDB"

  principals = var.principals
  policy_documents = [data.aws_iam_policy_document.developer.json]

  tags = {
    access-level = "read-write",
    access-type  = "developer",
    resource     = "dynamodb"
  }
}

module "product_role" {
  source = "./modules/aws-iam-for-resources" 
  name = "dynamodb_access_for_product"

  policy_description = "Allow DynamoDB read only access"
  role_description = "IAM role that allows Read-Only access to DynamoDB"

  principals = var.principals
  policy_documents = [data.aws_iam_policy_document.read_only.json]

  tags = {
    access-level = "read-only",
    access-type  = "product",
    resource     = "dynamodb"
  }
}

data "aws_iam_policy_document" "developer" {
  statement {
    sid = "LimitAccessToSpecificAttributes"
    effect = "Allow"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:ConditionCheckItem",
      "dynamodb:PutItem",
      "dynamodb:DescribeTable",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem"
    ]

    resources = ["arn:aws:dynamodb:us-east-2:000000000000:table/parsley"]

    condition {
      test = "ForAllValues:StringEquals"
      variable = "dynamodb:Attributes"
      values = [
        "Parsley-1",
        "Parsley-2",
        "ParsleyId"
      ]
    }
  }
}

data "aws_iam_policy_document" "read_only" {
  statement {
    sid = "LimitAccessToSpecificAttributes"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:BatchGetItem",
      "dynamodb:Scan",
    ]

    resources = ["arn:aws:dynamodb:us-east-2:000000000000:table/parsley"]

    condition {
      test = "ForAllValues:StringEquals"
      variable = "dynamodb:Attributes"
      values = [
        "Parsley-2",
        "ParsleyId"
      ]
    }
  }
}