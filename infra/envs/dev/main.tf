module "network" {
  source = "../../modules/network"

  name                       = var.name
  vpc_cidr                   = var.vpc_cidr
  azs                        = var.azs
  public_subnet_cidrs        = var.public_subnet_cidrs
  private_app_subnet_cidrs   = var.private_app_subnet_cidrs
  private_db_subnet_cidrs    = var.private_db_subnet_cidrs
}

module "ecs" {
  source = "../../modules/ecs"

  name               = var.name
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_app_subnet_ids
  container_image    = var.container_image
  cpu                = var.ecs_cpu
  memory             = var.ecs_memory
  desired_count      = var.ecs_desired_count
}

module "rds" {
  source = "../../modules/rds"

  name                    = var.name
  vpc_id                  = module.network.vpc_id
  db_subnet_ids           = module.network.private_db_subnet_ids
  ecs_security_group_id   = module.ecs.ecs_security_group_id
  instance_class          = var.rds_instance_class
  allocated_storage       = var.rds_allocated_storage
  backup_retention_period = var.rds_backup_retention_period
  deletion_protection     = var.rds_deletion_protection
  multi_az                = var.rds_multi_az
  db_name                 = var.rds_db_name
  db_username             = var.rds_username
  db_password             = var.rds_password
}

output "alb_dns_name" {
  value = module.ecs.alb_dns_name
}

output "rds_endpoint" {
  value = module.rds.endpoint
}
