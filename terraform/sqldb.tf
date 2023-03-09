data "azurerm_key_vault" "example" {
  name                = var.keyvaultname
  resource_group_name = var.resourcegroupvault
}

data "azurerm_key_vault_secret" "username" {
  name         = "SQLUSERNAME"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "password" {
  name         = "PASSWORD"
  key_vault_id = data.azurerm_key_vault.example.id
}

resource "azurerm_virtual_network" "example" {
  count    = var.create_vnet ? 1 : 0
  name                = "flaskapi-vnet"
  address_space       = var.vnetrange
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "internal" {
  count    = var.create_vnet ? 1 : 0
  name                 = "internalsql"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.example[0].name
  address_prefixes     = var.subnetrangesql
  service_endpoints    = ["Microsoft.Sql"]
  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
    }
  }
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
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}   

resource "azurerm_mysql_database" "mysql-db" {
  name                = var.dbname
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.mysql-server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_virtual_network_rule" "example" {
  count    = var.create_vnet ? 1 : 0
  name                = "mysql-vnet-rule"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.mysql-server.name
  subnet_id           = azurerm_subnet.internal[0].id
}

data "azurerm_monitor_diagnostic_categories" "mysqldb" {
  resource_id = azurerm_mysql_server.mysql-server.id
}

resource "azurerm_monitor_diagnostic_setting" "mysql" {
  name               = "webappmysql"
  target_resource_id = azurerm_mysql_server.mysql-server.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.monitor.id

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.mysqldb.logs
    content {
      category = log.value
      retention_policy {
        days    = 90
        enabled = true
      }
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}