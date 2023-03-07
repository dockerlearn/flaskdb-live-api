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

# data "azurerm_service_plan" "example" {
#   name                = "devops-dev-iothubscale-asp"
#   resource_group_name = "devops-dev"
# }

resource "azurerm_linux_web_app" "webapp" {
  name                  = "webapp-${random_integer.ri.result}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  service_plan_id       = azurerm_service_plan.appserviceplan.id
  https_only            = true
  app_settings          = local.default_app_settings
  site_config { 
    minimum_tls_version = "1.2"
    application_stack {
      docker_image = "shrey03/flaskapilive"
      docker_image_tag = "v6"
   }
  }
  logs {
    application_logs {
      file_system_level = "Error"
    }
  }  
}
