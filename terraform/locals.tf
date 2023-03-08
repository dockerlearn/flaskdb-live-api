#---------------------------------
# Local declarations
#---------------------------------
locals {

  default_app_settings = {
    SQLUSERNAME = data.azurerm_key_vault_secret.username.value
    PASSWORD = data.azurerm_key_vault_secret.password.value
    SERVER = azurerm_mysql_server.mysql-server.fqdn
    DBNAME = azurerm_mysql_database.mysql-db.name
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES = "20"
    WEBSITES_PORT = var.websiteport
    WEBSITES_CONTAINER_START_TIME_LIMIT = "420"
  }
}