output "user1" {
  value = module.atlas_cluster.user1
}

output "database_ro_username" {
  value = module.atlas_cluster.database_ro_username
}

output "database_rw_username" {
  value = module.atlas_cluster.database_rw_username
}

output "database_admin_username" {
  value = module.atlas_cluster.database_admin_username
}

output "cluster_connection_strings" {
  value = module.atlas_cluster.cluster_connection_strings
}

output "mongo_project_id" {
  value = module.atlas_cluster.mongo_project_id
}
