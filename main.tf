resource "aws_dynamodb_table" "parsley" {
  name           = var.table-name
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "PatientId"
  range_key      = "RecordId"

  # Keep track of each row, needs a partition ID
  attribute {
    name = "PatientId"
    type = "N"
  }

  attribute {
    name = "RecordId"
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

  tags = {
    Name        = "${var.table-name}-${var.environment}"
    Environment = var.environment
  }
}