######################################
########## MONGO DB ATLAS ############
######################################
gcp_project_id = "triple-acre-388315"
mongo_project_id      = "64779263a0390527428ccb1f"
mongo_public_key      = "cfzxderr"
mongo_private_key     = "6c90d964-f163-4e38-92f2-f86f96e677e3"
gcp_region            = "us-central1"
cloud_provider        = "GCP"
mongo_cluster_name    = "test-cluster-m"
mongo_cluster_version = "6.0"
mongo_cluster_type    = "REPLICASET"
cloud_backup          = true
autoscaling           = true
termination_protection_enabled = false
advanced_configuration = {
  javascript_enabled = true
  minimum_enabled_tls_protocol = "TLS1_2"
  oplog_min_retention_hours = 24
}
mongo_cluster_size    = "M10"
num_shards            = 1
regions_config = [
    {
      region_name  = "CENTRAL_US"
      electable_nodes       = 3
      priority              = 7
      read_only_nodes       = 0
    },
    {
      region_name     = "EASTERN_US"
      electable_nodes = 2
      priority        = 6
      read_only_nodes = 0
    },
    {
      region_name     = "WESTERN_US"
      electable_nodes = 2
      priority        = 5
      read_only_nodes = 2
    }
]
db_username           = "devuser"
db_password           = "user"
auth_database_name    = "admin"
db_role_name          = "readWriteAnyDatabase"
database_name         = "admin"
db_key                = "key"
db_value              = "value"
google_compute_address = "10.0.42."
google_compute_address_type = "INTERNAL"
network_name = "dev-newtork"
subnet_name = "dev-subnet"
compute_address_name = "dev-mongo"
