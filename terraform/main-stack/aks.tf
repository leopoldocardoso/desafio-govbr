resource "azurerm_kubernetes_cluster" "aks_desafio_gov_br" {
  name                = var.aks_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = var.aks_dns_prefix

  network_profile {
    network_plugin    = var.network_profile.network_plugin
    service_cidr      = var.network_profile.service_cidr
    dns_service_ip    = var.network_profile.dns_service_ip
    load_balancer_sku = var.network_profile.load_balancer_sku

  }

  default_node_pool {
    name           = "default"
    node_count     = var.node_count
    vm_size        = var.vm_size
    vnet_subnet_id = azurerm_subnet.snet_desafio_gov_br.id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  depends_on = [azurerm_virtual_network.vnet_desafio_gov_br, azurerm_subnet.snet_desafio_gov_br]
}


