resource "google_cloudfunctions_function" "cloud_fn" {
  name    = var.function_name
  runtime = "python39"

  source_archive_bucket = var.bucket_name
  source_archive_object = var.bucket_archive_name
  available_memory_mb   = 128
  trigger_http          = true
  ingress_settings      = "ALLOW_ALL"
  timeout               = 60
  entry_point           = "main"

  vpc_connector         = "projects/${var.project}/locations/${var.region}/connectors/${var.vpc_connector_name}"
  service_account_email = var.service_account_email
  environment_variables = {
    GCP_PROJECT_ID = var.project
    DB_USERNAME    = var.db_username
    DB_PASSWORD    = var.db_password
    DB_NAME        = var.db_name
    DB_HOST        = "${var.db_host}:5432"
  }

  max_instances = 3
}
