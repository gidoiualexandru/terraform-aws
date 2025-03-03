terraform {
  backend "s3" {
    bucket         = "terraform-state-example-company"
    key            = "staging/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

module "aws_infrastructure" {
  source = "../../"

  # Override default variables for staging environment
  aws_region = "us-east-1"
  
  # VPC
  vpc_cidr = "10.1.0.0/16"
  
  # EC2
  instance_type = "t3.small"
  asg_min_size = 2
  asg_max_size = 4
  asg_desired_capacity = 2
  
  # RDS
  db_instance_class = "db.t3.small"
  db_multi_az = true
  
  # S3
  bucket_prefix = "staging-app-data"
} 