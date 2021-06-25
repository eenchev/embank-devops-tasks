resource "google_service_account" "service_account" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}

resource "google_project_iam_member" "binding_service_account_role" {
  for_each = toset(var.custom_roles)
  role     = each.key
  member   = "serviceAccount:${google_service_account.service_account.email}"
}
