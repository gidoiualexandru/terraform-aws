# Terraform AWS Infrastructure

This repository provides a reusable Terraform infrastructure setup for AWS, allowing users to quickly provision and manage cloud resources. It follows best practices, uses a modular structure, and automates validation through GitHub Actions.

## Features

- **VPC**: Custom Virtual Private Cloud with public/private subnets
- **EC2**: Virtual machines with auto-scaling and security groups
- **RDS**: Managed relational database (MySQL/PostgreSQL)
- **S3**: Storage bucket with lifecycle policies
- **IAM**: Roles, policies, and least-privilege access

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0 or newer)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- IAM permissions to create required AWS resources

## Repository Structure 

terraform-aws-infra/
│── modules/ # Reusable Terraform modules
│ ├── vpc/ # VPC configuration
│ ├── ec2/ # EC2 instances setup
│ ├── rds/ # RDS database provisioning
│ ├── s3/ # S3 bucket setup
│ ├── iam/ # IAM roles and policies
│── environments/ # Environment-specific configurations
│ ├── dev/
│ ├── staging/
│ ├── production/
│── .github/workflows/ # CI/CD pipeline for Terraform validation
│── main.tf # Root Terraform configuration
│── variables.tf # Input variables
│── outputs.tf # Output values
│── terraform.tfvars # Variable definitions

## Getting Started

### Setting Up S3 Backend (Optional but Recommended)

Before applying the Terraform configuration, set up an S3 bucket and DynamoDB table for remote state storage:

bash
aws s3 mb s3://terraform-state-example-company
aws dynamodb create-table \
--table-name terraform-locks \
--attribute-definitions AttributeName=LockID,AttributeType=S \
--key-schema AttributeName=LockID,KeyType=HASH \
--billing-mode PAY_PER_REQUEST

### Basic Usage

1. Clone the repository:

bash
git clone
cd terraform-aws-infra

2. Initialize Terraform:

bash
terraform init

3. Review the plan:

bash
terraform plan

4. Apply the configuration:

bash
terraform apply

5. To destroy the infrastructure when no longer needed:

bash
terraform destroy

### Working with Environments

To deploy to a specific environment (dev, staging, or production):

bash
cd environments/dev
terraform init
terraform apply

## Customization

### Variables

The infrastructure can be customized by modifying the variables in `terraform.tfvars` or by providing them at runtime:

bash
terraform apply -var="instance_type=t3.large" -var="db_multi_az=true"


### Adding Resources

To add new resources, either extend the existing modules or create new ones in the `modules` directory.

## Security Best Practices

1. **IAM Policies**: All IAM policies follow the principle of least privilege.
2. **Secrets Management**: Database credentials are stored in AWS Secrets Manager.
3. **Network Security**: Resources are placed in private subnets where appropriate.
4. **S3 Bucket Security**: Public access is blocked by default.

## CI/CD Integration

This repository includes GitHub Actions workflows that:

1. Validate Terraform formatting and syntax on every PR
2. Generate and upload Terraform plans for review
3. Automatically apply changes on merges to main branch (when configured)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
