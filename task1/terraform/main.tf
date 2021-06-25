#----------------------------------------------------------------------------------------
# Cloud RUN support added in version 3.3.0 for Google provider
#----------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.14"

  required_providers {
    # Cloud Run support was added on 3.3.0
    google = ">= 3.3"
  }
}

#----------------------------------------------------------------------------------------
# Use Google provider
#----------------------------------------------------------------------------------------
provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

#----------------------------------------------------------------------------------------
variable "gcp_service_list" {
  description = "The list of APIs required for the project"
  type        = list(string)
  default = [
    "run.googleapis.com"
  ]
}

resource "google_project_service" "gcp_services" {
  for_each           = toset(var.gcp_service_list)
  service            = each.key
  disable_on_destroy = false
}

#-----------------------------------------------------------------------------------------
resource "google_cloud_run_service" "run_service" {
  name     = "loremapp"
  location = var.region

  template {
    spec {
      container_concurrency = 0
      containers {
        image = "gcr.io/${var.project}/loremapp:1.0.0"
      }
    }
  }

  metadata {
    annotations = {
      "autoscaling.knative.dev/maxScale" = "1000"
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_project_service.gcp_services]
}

#-----------------------------------------------------------------------------------------
# Allow unauthenticated users to invoke the service
#-----------------------------------------------------------------------------------------
resource "google_cloud_run_service_iam_member" "run_all_users" {
  service  = google_cloud_run_service.run_service.name
  location = google_cloud_run_service.run_service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

#-----------------------------------------------------------------------------------------
# Display the service URL
#-----------------------------------------------------------------------------------------
output "service_url" {
  value = google_cloud_run_service.run_service.status[0].url
}
