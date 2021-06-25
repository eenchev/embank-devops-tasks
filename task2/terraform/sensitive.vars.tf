variable "db_username" {
  description = "SQL Service account username"
  type        = string
}

variable "db_password" {
  description = "SQL Service account username"
  type        = string
  sensitive   = true
}
