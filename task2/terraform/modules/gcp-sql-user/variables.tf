#-----------------------------------------------------------------------------------
# REQUIRED CONFIGURATION VARIABLES
#-----------------------------------------------------------------------------------
variable "db_username" {
  description = "SQL Service account username"
  type        = string
}

variable "db_password" {
  description = "SQL Service account username"
  type        = string
  sensitive   = true
}

variable "db_instance_name" {
  description = "SQL instance name"
  type        = string
}
