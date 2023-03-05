data "azurerm_key_vault" "example" {
  name                = var.keyvaultname
  resource_group_name = var.resourcegroupvault
}

data "azurerm_key_vault_secret" "username" {
  name         = "USERNAME"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "password" {
  name         = "PASSWORD"
  key_vault_id = data.azurerm_key_vault.example.id
}

resource "azurerm_mysql_server" "mysql-server" {
  name = "${var.prefix}-mysql-server"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
 
  administrator_login          = data.azurerm_key_vault_secret.username.value
  administrator_login_password = data.azurerm_key_vault_secret.password.value
 
  sku_name = var.mysql-sku-name
  version  = var.mysql-version
 
  storage_mb        = var.mysql-storage
  auto_grow_enabled = true
  
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}   

resource "azurerm_mysql_database" "mysql-db" {
  name                = var.dbname
  resource_group_name = azurerm_resource_group.mysql-rg.name
  server_name         = azurerm_mysql_server.mysql-server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}