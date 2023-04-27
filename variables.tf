######################################
########## MONGO DB ATLAS ############
######################################
variable "gcp_project_id" {
  type        = string
  description = "GCP Project ID"
}
variable "mongo_project_id" {
  type        = string
  description = "Mongo Atlas Project ID "
}
variable "mongo_public_key" {
  type        = string
  description = ""
}
variable "mongo_private_key" {
  type        = string
  description = ""
}
variable "gcp_region" {
  type        = string
  description = ""
}
variable "cloud_provider" {
  type        = string
  description = ""
}
variable "mongo_cluster_name" {
  type        = string
  description = ""
}
variable "mongo_cluster_version" {
  type        = string
  description = ""
}
variable "mongo_cluster_type" {
  type        = string
  description = ""
}
variable "cloud_backup" {
  type        = bool
  description = ""
}
variable "autoscaling" {
  type        = bool
  description = ""
}
variable "mongo_cluster_size" {
  type        = string
  description = ""
}
variable "num_shards" {
  type        = number
  description = ""
}
variable "mongo_cluster_region" {
  type        = string
  description = ""
}
variable "electable_nodes" {
  type        = number
  description = ""
}
variable "priority" {
  type        = number
  description = ""
}
variable "read_only_nodes" {
  type        = number
  description = ""
}
variable "subnet" {
  type        = string
  description = ""
}
# Database user
variable "db_username" {
  type        = string
  description = ""
}
variable "db_password" {
  type        = string
  description = ""
}
variable "auth_database_name" {
  type        = string
  description = ""
}
variable "db_role_name" {
  type        = string
  description = ""
}
variable "database_name" {
  type        = string
  description = ""
}
variable "db_key" {}
variable "db_value" {}
variable "google_compute_address" {}
variable "google_compute_address_type" {

}
