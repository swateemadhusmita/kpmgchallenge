resource "azurerm_public_ip" "app_publicip" {
  name                = "greenapp-publicip-lb"
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "app_lb" {
  name                = "greenapp_lb"
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.app_publicip.id
  }
}
resource "azurerm_lb_backend_address_pool" "appbackend_pool" {
  loadbalancer_id = azurerm_lb.app_lb.id
  name            = "greenapp-web-pool"
  resource_group_name= azurerm_resource_group.apprg.name
}
resource "azurerm_lb_backend_address_pool_address" "appbackend_pooladdress" {
  name                    = "greenapp-web-pooladdress"
  backend_address_pool_id = azurerm_lb_backend_address_pool.appbackend_pool.id
  virtual_network_id      = azurerm_virtual_network.app_vnet.id
  ip_address              = azurerm_linux_virtual_machine.web_vm.private_ip_address
}