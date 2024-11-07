# AWS Tooling Infrastructure

Within this reposistory contains the following:

1. Customer Cloudformation template which contains a 'Iam Role' and a 'trust policy' which allows the Build IAM User in the tooling to account to assume this role, and a 'S3 Bucket' to store the 'terraform.tfstate' file for that account's terraform confugration.

2. Using the customer's account id as a parameter, and a scoped down IAM Policy which when created in our tooling account, allows our IAM Tooling account's IAM user to only assume the build role in the customer account.

The CloudFormation stack will be given the customer to launch as a stack in their account, and we will then take the custumer account id, and use it as a parameter in our 'tf-apply.yml' pipeline, which will then change our IAM Tooling accounts IAM policy to scope down the policy to only use this policy. 

There is also a 'tf-delete' pipeline which runs when we want to remove our terraform infrastructure.