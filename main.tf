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