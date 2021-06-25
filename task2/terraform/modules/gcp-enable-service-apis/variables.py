#-----------------------------------------------------------------------------------
# OPTIONAL CONFIGURATION VARIABLES
#-----------------------------------------------------------------------------------
variable "gcp_service_list" {
  description ="The list of APIs required for the project"
  type = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "cloudbuild.googleapis.com",
    "serviceusage.googleapis.com",
    "iam.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "sqladmin.googleapis.com",
    "vpcaccess.googleapis.com"
  ]
}


