# Create a resource group
resource "azurerm_resource_group" "this" {
  name     = "tcb"
  location = "East US"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "this" {
  name                = "Bootcamp"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.2.0.0/24"]
}