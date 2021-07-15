awslocal iam detach-user-policy --user-name localstack-tester --policy-arn arn:aws:iam::000000000000:policy/dynamodbRO
awslocal iam delete-policy --policy-arn arn:aws:iam::000000000000:policy/dynamodbRO
awslocal iam attach-user-policy --user-name localstack-tester --policy-arn arn:aws:iam::000000000000:policy/dynamodbRO
awslocal dynamodb get-item --table-name parsley --key file://dynamo-read.json