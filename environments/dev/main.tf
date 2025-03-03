terraform {
  backend "s3" {
    bucket         = "terraform-state-example-company"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

module "aws_infrastructure" {
  source = "../../"

  # Override default variables for dev environment
  aws_region = "us-east-1"
  
  # VPC
  vpc_cidr = "10.0.0.0/16"
  
  # EC2
  instance_type = "t3.micro"
  asg_min_size = 1
  asg_max_size = 2
  asg_desired_capacity = 1
  
  # RDS
  db_instance_class = "db.t3.micro"
  db_multi_az = false
  
  # S3
  bucket_prefix = "dev-app-data"
} 