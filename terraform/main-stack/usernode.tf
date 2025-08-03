resource "azurerm_kubernetes_cluster_node_pool" "user_node" {
  name                  = var.user_node_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_desafio_gov_br.id
  vm_size               = var.vm_size
  node_count            = var.node_count
  depends_on            = [azurerm_kubernetes_cluster.aks_desafio_gov_br]
  tags = var.tags
}
