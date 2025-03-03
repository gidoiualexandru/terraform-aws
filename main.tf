provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-${var.company_name}"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

  environment        = terraform.workspace
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "s3" {
  source = "./modules/s3"

  environment           = terraform.workspace
  bucket_prefix         = var.bucket_prefix
  ia_transition_days    = var.ia_transition_days
  glacier_transition_days = var.glacier_transition_days
  expiration_days       = var.expiration_days
}

module "iam" {
  source = "./modules/iam"

  environment    = terraform.workspace
  s3_bucket_arn  = module.s3.bucket_arn
  db_secret_arn  = module.rds.db_secret_arn
}

module "ec2" {
  source = "./modules/ec2"

  environment           = terraform.workspace
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.public_subnet_ids
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  key_name              = var.key_name
  instance_profile_name = module.iam.instance_profile_name
  user_data             = var.user_data
  min_size              = var.asg_min_size
  max_size              = var.asg_max_size
  desired_capacity      = var.asg_desired_capacity
}

module "rds" {
  source = "./modules/rds"

  environment           = terraform.workspace
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  app_security_group_id = module.ec2.security_group_id
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  db_port               = var.db_port
  db_engine             = var.db_engine
  db_engine_version     = var.db_engine_version
  db_instance_class     = var.db_instance_class
  allocated_storage     = var.db_allocated_storage
  skip_final_snapshot   = var.db_skip_final_snapshot
  multi_az              = var.db_multi_az
  backup_retention_period = var.db_backup_retention_period
  backup_window         = var.db_backup_window
  maintenance_window    = var.db_maintenance_window
  db_parameter_group_name = var.db_parameter_group_name
} 