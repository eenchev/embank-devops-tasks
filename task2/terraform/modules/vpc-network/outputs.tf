output "network_id" {
  description = "ID of the VPC network created"
  value       = google_compute_network.vpc_network.id
}

output "network_name" {
  description = "Name of the VPC network created"
  value       = google_compute_network.vpc_network.name
}
