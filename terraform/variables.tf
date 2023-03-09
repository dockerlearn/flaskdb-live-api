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

variable "create_vnet" {
  type        = bool
  description = "Enable vnet for connection"
  default = true
}

variable "docker_image" {
  type = string
  description = "docker image url to pull image"
  default = "shrey03/flaskapilive"
}

variable "docker_image_tag" {
  type = string
  description = "docker image tag to pull image"
  default = "v7"
}

variable "mysql-version" {
  type = string
  description = "MySQL Server version to deploy"
  default = "8.0"
}
variable "mysql-sku-name" {
  type = string
  description = "MySQL SKU Name"
  default = "GP_Gen5_2"
}
variable "mysql-storage" {
  type = string
  description = "MySQL Storage in MB"
  default = "5120"
}

variable "geo_redundant_backup_enabled" {
  type        = string
  description = "Turn Geo-redundant server backups on/off."
  default = "true"
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

variable "vnetrange" {
  type = list
  description = "Vnet IP range"
  default = ["10.186.40.64/26"]
}

variable "subnetrangesql" {
  type = list
  description = "Subnet IP range"
  default = ["10.186.40.64/28"]
}

variable "websiteport" {
  description = "Port for application"
  type = number
  default = 5000
}