
resource "azurerm_virtual_network" "vnet_desafio_gov_br" {
  name                = var.vnet_desafio_gov_br
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = var.address_space_vnet
  tags                = var.tags
  depends_on          = [azurerm_resource_group.this]
}

resource "azurerm_subnet" "snet_desafio_gov_br" {
  name                 = var.subnet_desafio_gov_br
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.vnet_desafio_gov_br.name
  address_prefixes     = var.address_space_snet
  depends_on           = [azurerm_virtual_network.vnet_desafio_gov_br]
}
