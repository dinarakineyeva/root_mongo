output "db_user" {
  value = module.atlas_cluster.user1
}

output "database-rw-user" {
  value = module.atlas_cluster.database-rw-user
}

output "database-admin-user" {
  value = module.atlas_cluster.database-admin-user
}

output "name" {
  value = module.atlas_cluster.connection_string
}
