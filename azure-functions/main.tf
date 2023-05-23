resource "azurerm_resource_group" "test" {
 location  = var.location_resource_group
 name  = var.name_resource_group
}
resource "azurerm_storage_account" "test" {
  account_replication_type = var.account_replication_type_storage_account
  account_tier             = var.account_tier_storage_account
  location                 = azurerm_resource_group.test.location
  name                     = var.name_storage_account
  resource_group_name      = azurerm_resource_group.test.name
}
resource "azurerm_app_service_plan" "test" {
  location            = azurerm_resource_group.test.location
  name                = var.name_app_service_plan
  resource_group_name = azurerm_resource_group.test.name
  sku {
    size = var.size_sku_app_service_plan
    tier = var.tier_sku_app_service_plan
  }
}
resource "azurerm_linux_function_app" "test" {
  location            = azurerm_resource_group.test.location
  name                = var.name_linux_function_app
  resource_group_name = azurerm_resource_group.test.name
  service_plan_id     = azurerm_app_service_plan.test.id
  site_config {}
}

resource "azurerm_function_app_function" "test" {
  config_json     = jsonencode({
    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "methods" = [
          "get",
          "post",
        ]
        "name" = "req"
        "type" = "httpTrigger"
      },
      {
        "direction" = "out"
        "name"      = "$return"
        "type"      = "http"
      },
    ]
  })
  function_app_id = azurerm_linux_function_app.test.id
  name            = var.name_function_app_function
}
