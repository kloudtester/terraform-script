provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "sairg" {
  name     = var.resource_group_name
  location = var.target_region
}
