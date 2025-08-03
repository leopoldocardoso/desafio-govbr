terraform {
  backend "azurerm" {
    resource_group_name  = "rg-iac-terraform"
    storage_account_name = "iacdevterraformtfstate"
    container_name       = "container-iac"
    key                  = "desafio-gov-br.tfstate"

  }
}
