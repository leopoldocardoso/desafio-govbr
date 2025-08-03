variable "rg_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-desafio-gov-br"
}

variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string
  default     = "eastus"
}

variable "vnet_desafio_gov_br" {
  description = "The name of the virtual network."
  type        = string
  default     = "vnet-desafio-gov-br"
}

variable "subnet_desafio_gov_br" {
  description = "The name of the subnet within the virtual network."
  type        = string
  default     = "snet-desafio-gov-br"
}

variable "address_space_vnet" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["192.168.0.0/16"]

}

variable "address_space_snet" {
  description = "The address space for the subnet."
  type        = list(string)
  default     = ["192.168.1.0/24"]
}

variable "aks_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "aks-desafio-gov-br"
}

variable "aks_dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
  default     = "aksdesafiogovbr"
}

variable "network_profile" {
  description = "The network profile for the AKS cluster."
  type = object({
    network_plugin    = string
    service_cidr      = string
    dns_service_ip    = string
    load_balancer_sku = string
  })
  default = {
    network_plugin    = "azure"
    service_cidr      = "10.0.0.0/16"
    dns_service_ip    = "10.0.0.10"
    load_balancer_sku = "standard"
  }

}

variable "vm_size" {
  description = "The VM size for the default node pool in the AKS cluster."
  type        = string
  default     = "Standard_D2_v2"
}

variable "user_node_name" {
  description = "The name of the user node pool in the AKS cluster."
  type        = string
  default     = "aksusernode"

}

variable "node_count" {
  description = "The number of nodes in the default node pool in the AKS cluster."
  type        = number
  default     = 2
}

variable "azure_container_registry" {
  description = "The name of the Azure Container Registry."
  type = object({
    name          = string
    sku           = string
    admin_enabled = bool
  })
  default = {
    name          = "ecrdesafiogovbr"
    sku           = "Basic"
    admin_enabled = false
  }
}


variable "tags" {
  description = "A map of tags to assign to the resource group."
  type        = map(string)
  default = {
    "environment" = "development"
    "team"        = "devops"
    "project"     = "desafio-gov-br"
  }
}
