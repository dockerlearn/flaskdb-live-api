variable "app_settings" {
    type = map
    default = {
        USERNAME = "testshrey"
        PASSWORD = "@Microsoft.KeyVault(SecretUri=https://dbvaulttv.vault.azure.net/secrets/mysecret/)"
    }
}

variable "mysql-version" {
  type = string
  description = "MySQL Server version to deploy"
  default = "8.0"
}
variable "mysql-sku-name" {
  type = string
  description = "MySQL SKU Name"
  default = "8.0"
}
variable "mysql-storage" {
  type = string
  description = "MySQL Storage in MB"
  default = "5120"
}

variable "keyvaultname" {
  type = string
  description = "Key vault name"
}
variable "resourcegroupvault" {
  type = string
  description = "resourcegroup of vault"
}

variable "dbname" {
  type = string
  description = "Database name"
}