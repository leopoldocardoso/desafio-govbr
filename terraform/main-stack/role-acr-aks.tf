resource "azurerm_role_assignment" "role_acr_aks" {
  principal_id                     = azurerm_kubernetes_cluster.aks_desafio_gov_br.identity[0].principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr_desafio_gov_br.id
  skip_service_principal_aad_check = true
  depends_on = [ azurerm_container_registry.acr_desafio_gov_br, azurerm_kubernetes_cluster.aks_desafio_gov_br ]
}
