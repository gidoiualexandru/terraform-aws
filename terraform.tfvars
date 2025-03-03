aws_region = "us-east-1"
company_name = "example-company"

# VPC
vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]

# EC2
ami_id = "ami-0c55b159cbfafe1f0"
instance_type = "t3.micro"
asg_min_size = 1
asg_max_size = 3
asg_desired_capacity = 2

# RDS
db_name = "appdb"
db_username = "admin"
db_password = "YourStrongPasswordHere123!"
db_engine = "postgres"
db_engine_version = "13.4"
db_instance_class = "db.t3.micro"
db_allocated_storage = 20
db_multi_az = false

# S3
bucket_prefix = "app-data"
ia_transition_days = 30
glacier_transition_days = 60
expiration_days = 365 