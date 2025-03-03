terraform {
  backend "s3" {
    bucket         = "terraform-state-example-company"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

module "aws_infrastructure" {
  source = "../../"

  # Override default variables for production environment
  aws_region = "us-east-1"
  
  # VPC
  vpc_cidr = "10.2.0.0/16"
  
  # EC2
  instance_type = "t3.medium"
  asg_min_size = 2
  asg_max_size = 6
  asg_desired_capacity = 3
  
  # RDS
  db_instance_class = "db.t3.medium"
  db_multi_az = true
  db_backup_retention_period = 14
  
  # S3
  bucket_prefix = "prod-app-data"
} 