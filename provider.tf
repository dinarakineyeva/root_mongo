terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0"
    }
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }
  required_version = ">= 0.13"
}

provider "google-beta" {
  project     = var.project_id
  credentials = file("creds.json")
}

provider "google" {
  project     = var.gcp_project_id
  credentials = file("creds.json")
}

provider "mongodbatlas" {
  public_key  = var.mongo_public_key
  private_key = var.mongo_private_key
}
