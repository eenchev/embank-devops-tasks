#-----------------------------------------------------------------------------------
# REQUIRED CONFIGURATION VARIABLES
#-----------------------------------------------------------------------------------
variable "service_account_id" {
  description = "Service account ID"
  type        = string
}

#-----------------------------------------------------------------------------------
# OPTIONAL CONFIGURATION VARIABLES
#-----------------------------------------------------------------------------------
variable "service_account_display_name" {
  description = "Human readable display name for the service account"
  type        = string
  default     = ""
}
variable "custom_roles" {
  description = "Roles to assign for the service account"
  type        = list(string)
  default     = []
}

