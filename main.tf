#######################################
########## MONGO DB ATLAS #############
#######################################
module "atlas_cluster" {
  source = "../child_module"
  org_id = var.org_id

  # ==== Private link ==== #
  gcp_project = var.gcp_project_id
  gcp_region  = var.gcp_region

  # ==== Atlas cluster ==== #
  project_name                   = var.project_name
  cloud_provider                 = var.cloud_provider
  cluster_name                   = var.mongo_cluster_name
  mongodbversion                 = var.mongo_cluster_version
  cluster_type                   = var.mongo_cluster_type
  cloud_backup                   = var.cloud_backup
  termination_protection_enabled = var.termination_protection_enabled
  auto_scaling_disk_gb_enabled   = var.autoscaling
  provider_instance_size_name    = var.mongo_cluster_size
  advanced_configuration         = var.advanced_configuration

  # ==== replication_specs for the cluster ==== #
  num_shards     = var.num_shards
  regions_config = var.regions_config

  # ==== Database user ==== # 
  db_username        = var.db_username
  db_password        = var.db_password
  auth_database_name = var.auth_database_name

  # ==== roles ==== #
  db_role_name  = var.db_role_name
  database_name = var.database_name
  # ==== labels ==== #
  db_key   = var.db_key
  db_value = var.db_value

  # ==== internal backups ==== #
  description       = var.description
  retention_in_days = var.retention_in_days

  google_compute_address      = var.google_compute_address
  google_compute_address_type = var.google_compute_address_type
  environment                 = var.environment
  compute_address_name        = var.compute_address_name
}
