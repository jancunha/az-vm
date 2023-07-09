data "azurerm_ssh_public_key" "this" {
  name                = "azkey"
  resource_group_name = "NHT"
}

resource "azurerm_linux_virtual_machine" "this" {
  name                            = "vmlab1"
  resource_group_name             = azurerm_resource_group.this.name
  location                        = azurerm_resource_group.this.location
  size                            = "Standard_B1s"
  admin_username                  = "azureuser"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_ssh_key {
    username = "azureuser"
    public_key = data.azurerm_ssh_public_key.this.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.this.public_ip_address
}