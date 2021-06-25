resource "google_storage_bucket" "cloud_fn_bucket" {
  name = var.bucket_name
}

resource "google_storage_bucket_object" "cloud_fn_archive" {
  name   = var.file_name
  bucket = google_storage_bucket.cloud_fn_bucket.name
  source = "../out/${var.file_name}"
}
