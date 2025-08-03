resource "azurerm_container_registry" "acr_desafio_gov_br" {
  name                = var.azure_container_registry.name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = var.azure_container_registry.sku
  admin_enabled       = var.azure_container_registry.admin_enabled
  tags                = var.tags
  depends_on          = [azurerm_resource_group.this]

}
