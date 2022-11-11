resource "azurerm_linux_virtual_machine" "main" {
  name                = var.linux_virtual_machine_name
  location            = var.target_region
  resource_group_name = var.resource_group_name
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