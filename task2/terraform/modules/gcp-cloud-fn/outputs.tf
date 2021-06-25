output "url" {
  description = "URL of Trigger for Cloud Function created"
  value       = google_cloudfunctions_function.cloud_fn.https_trigger_url
}
