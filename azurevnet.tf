provider "azurerm" {
  features {}

}

resource "azurerm_resource_group" "sairg" {
  name     = "sai1resource"
  location = "West Europe"
}


resource "azurerm_virtual_network" "vnet" {
  name                = "sainetwork"
  location            = azurerm_resource_group.sairg.location
  resource_group_name = azurerm_resource_group.sairg.name
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "pubsub" {
  name                 = "public"
  resource_group_name  = azurerm_resource_group.sairg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "prisub" {
  name                 = "private"
  resource_group_name  = azurerm_resource_group.sairg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_public_ip" "terra-demo" {
  name                = "demo"
  resource_group_name = azurerm_resource_group.sairg.name
  location            = azurerm_resource_group.sairg.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.sairg.location
  resource_group_name = azurerm_resource_group.sairg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.pubsub.id
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.terra-demo.id
    private_ip_address_allocation = "Dynamic"
  } 
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "saivm"
  location            = azurerm_resource_group.sairg.location
  resource_group_name = azurerm_resource_group.sairg.name
  size                = "Standard_D2_v2"
  admin_username      = "satya"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "satya"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "Ubuntuserver"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}