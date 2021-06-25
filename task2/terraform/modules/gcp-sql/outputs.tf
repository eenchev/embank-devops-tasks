output "instance_name" {
  value       = google_sql_database_instance.db_instance.name
  description = "The instance name for the master instance"
}

output "private_ip_address" {
  description = "The first private (PRIVATE) IPv4 address assigned for the master instance"
  value       = google_sql_database_instance.db_instance.private_ip_address
}
