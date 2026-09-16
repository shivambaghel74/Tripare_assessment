aws_region = "ap-south-1"
environment = "dev"
name        = "tripare-dev"

vpc_cidr = "10.20.0.0/16"

azs = [
  "ap-south-1a",
  "ap-south-1b"
]

public_subnet_cidrs = [
  "10.20.1.0/24",
  "10.20.2.0/24"
]

private_app_subnet_cidrs = [
  "10.20.11.0/24",
  "10.20.12.0/24"
]

private_db_subnet_cidrs = [
  "10.20.21.0/24",
  "10.20.22.0/24"
]

container_image = "nginx:1.27-alpine"

rds_instance_class          = "db.t4g.micro"
rds_allocated_storage       = 20
rds_backup_retention_period = 3
rds_deletion_protection     = false
rds_multi_az                = false
rds_db_name                 = "bookings"
rds_username                = "bookings_admin"
rds_password                = "CHANGE_ME_PLAN_ONLY"

ecs_desired_count = 1
ecs_cpu           = 256
ecs_memory        = 512
