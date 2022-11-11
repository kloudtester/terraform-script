
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = var.target_region
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}
resource "azurerm_subnet" "saipub" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}
resource "azurerm_public_ip" "terra-demo" {
  name                = "demo"
  resource_group_name = var.resource_group_name
  location            = var.target_region
  allocation_method   = "Static"
}
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = var.target_region
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.saipub.id
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.terra-demo.id
    private_ip_address_allocation = "Dynamic"
  }
}