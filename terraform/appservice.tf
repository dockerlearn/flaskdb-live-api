# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup-${random_integer.ri.result}"
  location = var.location
}


# Create the Linux App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = "webapp-asp-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "webapp" {
  name                  = "webapp-${random_integer.ri.result}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  service_plan_id       = azurerm_service_plan.appserviceplan.id
  https_only            = true
  app_settings          = local.default_app_settings
  virtual_network_subnet_id = try(azurerm_subnet.internal[0].id, null)
  site_config { 
    minimum_tls_version = "1.2"
    application_stack {
      docker_image = var.docker_image
      docker_image_tag = var.docker_image_tag
   }
  }
  logs {
    application_logs {
      file_system_level = "Error"
    }
  }
  depends_on = [
    azurerm_subnet.internal
 ]  
}

resource "azurerm_log_analytics_workspace" "monitor" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = "webapp-flaskapi"
  sku                 = "PerGB2018"
  retention_in_days   = 90
}

data "azurerm_monitor_diagnostic_categories" "webapp" {
  resource_id = azurerm_linux_web_app.webapp.id
}

resource "azurerm_monitor_diagnostic_setting" "webapp" {
  name               = "webappflask"
  target_resource_id = azurerm_linux_web_app.webapp.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.monitor.id

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.webapp.logs
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