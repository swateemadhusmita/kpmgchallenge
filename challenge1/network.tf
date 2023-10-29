resource "azurerm_resource_group" "apprg" {
  name     = "greenapp-resources"
  location = "West Europe"
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = "greenapp-security-group"
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name
}

resource "azurerm_virtual_network" "app_vnet" {
  name                = "greenapp-network"
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "app_subnet" {
  name                 = "greenapp-subnet"
  resource_group_name  = azurerm_resource_group.apprg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}