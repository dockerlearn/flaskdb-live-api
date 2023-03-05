#---------------------------------
# Local declarations
#---------------------------------
locals {

  default_app_settings = {
    USERNAME = "testshrey"
    PASSWORD = data.azurerm_key_vault_secret.example.value
    SERVER = azurerm_mysql_server.mysql-server.fqdn
    DBNAME = azurerm_mysql_database.mysql-db.name
  }
}