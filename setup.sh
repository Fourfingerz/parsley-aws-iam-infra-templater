# localstack running on docker-compose
docker-compose up --force-recreate --bulid -data
terraform init && terraform apply -auto-approve
awslocal dynamodb batch-write-item --request-items file://seed-data-dyno-format.json
awslocal dynamodb scan --table-name parsley # verify

# testing IAM enforcement strategy
awslocal iam create-user --user-name localstack-tester
awslocal iam create-access-key --user-name --user-name localstack-tester