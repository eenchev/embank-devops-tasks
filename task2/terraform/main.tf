provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
#-------------------------------------------------------------------------------------
module "service_api_requirements" {
  source = "./modules/gcp-enable-service-apis"
}

module "service_account" {
  source = "./modules/gcp-service-account"

  service_account_id           = "sa-network-viewer"
  service_account_display_name = "Network Resources Viewer"
  custom_roles                 = ["roles/compute.networkViewer"]
}

module "vpc_network" {
  source = "./modules/vpc-network"

  network_name = "network-viewer-vpc"
}

module "vpc_network_connector" {
  source = "./modules/vpc-serverless-connector"

  network_name           = module.vpc_network.network_name
  vpc_connector_name     = "network-viewer-vpc-con"
  reserved_ip_cidr_range = "10.122.0.0/28"
}

module "managed_postgresql" {
  source = "./modules/gcp-sql"

  database_name      = "networks"
  private_network_id = module.vpc_network.network_id
}

module "managed_postgresql_user" {
  source = "./modules/gcp-sql-user"

  db_username      = var.db_username
  db_password      = var.db_password
  db_instance_name = module.managed_postgresql.instance_name
}

module "gcs_bucket" {
  source = "./modules/gcs-bucket"

  bucket_name = "embank_devops_task2_bucket"
  file_name   = "cloud_fn.zip"
}

module "cloud_fn" {
  source = "./modules/gcp-cloud-fn"

  function_name         = "network-info-exporter-fn"
  service_account_email = module.service_account.email
  bucket_name           = "embank_devops_task2_bucket"
  bucket_archive_name   = "cloud_fn.zip"
  project               = var.project
  region                = var.region
  vpc_connector_name    = "network-viewer-vpc-con"
  db_username           = var.db_username
  db_password           = var.db_password
  db_name               = "networks"
  db_host               = module.managed_postgresql.private_ip_address
}
