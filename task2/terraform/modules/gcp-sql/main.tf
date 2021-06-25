resource "random_string" "four_chars" {
  length  = 4
  upper   = false # instance names can only have lowercase letters, numbers, and hyphens
  special = false
}

resource "google_sql_database" "db" {
  name     = var.database_name
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_database_instance" "db_instance" {
  name             = "${var.database_name}-db-instance-${random_string.four_chars.result}"
  database_version = "POSTGRES_13"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_network_id
    }
  }

  deletion_protection = "false"
}

