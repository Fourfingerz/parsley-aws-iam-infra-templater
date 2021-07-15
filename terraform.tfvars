environment = "dev"
table-name  = "parsley"
region      = "us-east-1"
principals  = ["arn:aws:iam::000000000000:role/localstack_tester"]  # arns of AWS roles you want to assign that can STS:assume your role