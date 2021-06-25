#-----------------------------------------------------------------------------------
# REQUIRED CONFIGURATION VARIABLES
#-----------------------------------------------------------------------------------
variable "function_name" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_archive_name" {
  type = string
}

variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_connector_name" {
  type = string
}


variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  type = string
}

variable "db_host" {
  type = string
}
