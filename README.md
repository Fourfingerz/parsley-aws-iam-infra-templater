# parsley-aws-iam-infra-templater

Steps:
1. Use docker-compose to up a localstack to replicate AWS local env.
2. Run setup.sh to spin up DynamoDB and IAM roles for testing.
3. After script runs, you should `EXPORT` the AWS Key and ID to assume that user and test the roles for Dynamodb.