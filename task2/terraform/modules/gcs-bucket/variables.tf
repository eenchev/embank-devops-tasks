#-----------------------------------------------------------------------------------
# REQUIRED CONFIGURATION VARIABLES
#-----------------------------------------------------------------------------------
variable "bucket_name" {
  description = "Globally unique bucket name"
  type        = string
}

variable "file_name" {
  description = "Cloud Function ZIP that is found in out file and will be uploaded to bucket"
  type        = string
}
