resource "google_vpc_access_connector" "vpc_connector" {
  network       = var.network_name
  name          = var.vpc_connector_name
  ip_cidr_range = var.reserved_ip_cidr_range
}

