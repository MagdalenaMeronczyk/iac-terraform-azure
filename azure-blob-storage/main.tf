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
resource "azurerm_storage_container" "test" {
  name                 = var.name_azurerm_storage_container
  storage_account_name = azurerm_storage_account.test.name
}
resource "azurerm_storage_blob" "test" {
  name                   = var.name_storage_blob
  storage_account_name   = azurerm_storage_account.test.name
  storage_container_name = azurerm_storage_container.test.name
  type                   = var.type_storage_blob
}
