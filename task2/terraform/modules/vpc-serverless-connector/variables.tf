#-----------------------------------------------------------------------------------
# REQUIRED CONFIGURATION VARIABLES
#-----------------------------------------------------------------------------------
variable "network_name" {
  description = "The name of the network this VPC connector connects to"
  type        = string
}

variable "vpc_connector_name" {
  description = "The name of this VPC connector"
  type        = string
}

variable "reserved_ip_cidr_range" {
  description = "Private IP CIDR reserved for this VPC connector"
  type        = string
}
