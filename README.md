# parsley-aws-iam-infra-templater

Requirements:
Installed `awscli` and `localstack/awscli-local` packages.
Docker client running.
Terraform 0.13 and up.

Steps:
1. Use docker-compose to up a localstack to replicate AWS local env.
2. Run setup.sh to spin up DynamoDB and IAM roles for testing.
3. After script runs, you should `EXPORT` the AWS Key and ID to assume that user and test the roles for Dynamodb.
