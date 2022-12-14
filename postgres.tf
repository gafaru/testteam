module "postgresql_rds" {
  source = "../modules/terraform-aws-postgresql-rds"
  vpc_id = var.vpc_id
  allocated_storage = "32"
  engine_version = "13.7"
  instance_type = "db.m5.large"
  storage_type = "gp2"
  database_identifier = "teamcitydb"
  database_name = "teamcity"
  database_username = "adminuser"
  database_password = "xxxxx"
  database_port = "5432"
  backup_retention_period = "30"
  backup_window = "04:00-04:30"
  maintenance_window = "sun:04:30-sun:05:30"
  auto_minor_version_upgrade = false
  multi_availability_zone = true
  storage_encrypted = false
  subnet_group = "default-vpc-xxx"
  #parameter_group = "default-pg"
  monitoring_interval = "60"
  deletion_protection = true
}
