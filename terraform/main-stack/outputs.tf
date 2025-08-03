output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_desafio_gov_br.name
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_desafio_gov_br.kube_config_raw
  sensitive = true
}

output "acr_desafio_gov_br" {
  value = azurerm_container_registry.acr_desafio_gov_br.name
}




