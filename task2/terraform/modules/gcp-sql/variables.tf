#-----------------------------------------------------------------------------------
# REQUIRED CONFIGURATION VARIABLES
#-----------------------------------------------------------------------------------
variable "database_name" {
  description = "Name of the initial DB schema"
  type        = string
}

variable "private_network_id" {
  description = "ID of VPC network"
  type        = string
}
