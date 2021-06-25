resource "google_sql_user" "network_lister_db_user" {
  name     = var.db_username
  password = var.db_password
  instance = var.db_instance_name
}
