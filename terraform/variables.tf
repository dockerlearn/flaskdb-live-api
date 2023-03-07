variable "location" {
  type        = string
  description = "Location in which resources will be created"
  default = "northeurope"
}

variable "prefix" {
  type        = string
  description = "This variable defines the company name prefix used to build resources"
  default = "tstshrey01"
}

variable "sku_name" {
  type        = string
  description = "sku for app service plan"
  default = "P1v2"
}

variable "mysql-version" {
  type = string
  description = "MySQL Server version to deploy"
  default = "8.0"
}
variable "mysql-sku-name" {
  type = string
  description = "MySQL SKU Name"
  default = "B_Gen5_1"
}
variable "mysql-storage" {
  type = string
  description = "MySQL Storage in MB"
  default = "5120"
}

variable "keyvaultname" {
  type = string
  description = "Key vault name"
  default = "akscerttst"
}
variable "resourcegroupvault" {
  type = string
  description = "resourcegroup of vault"
  default = "devops-dev"
}

variable "dbname" {
  type = string
  description = "Database name"
  default = "flaskapidb"
}

variable "websiteport" {
  description = "Port for application"
  type = number
  default = 5000
}