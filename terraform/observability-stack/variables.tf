variable "rg_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-desafio-gov-br"
}


variable "aks_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "aks-desafio-gov-br"
}

variable "monitoring_namespace" {
  description = "Namespace para o monitoring"
  type        = string
  default     = "monitoring"
}

variable "grafana_admin_password" {
  description = "Senha do admin do Grafana"
  type        = string
  sensitive   = true
  default     = "admin123"
}

variable "enable_ingress" {
  description = "Habilitar Ingress para Grafana"
  type        = bool
  default     = false
}

variable "grafana_domain" {
  description = "Domínio para o Grafana (se ingress habilitado)"
  type        = string
  default     = "grafana.example.com"
}

variable "prometheus_retention" {
  description = "Tempo de retenção dos dados do Prometheus"
  type        = string
  default     = "30d"
}

variable "prometheus_storage_size" {
  description = "Tamanho do storage do Prometheus"
  type        = string
  default     = "10Gi"
}

variable "grafana_storage_size" {
  description = "Tamanho do storage do Grafana"
  type        = string
  default     = "10Gi"
}

variable "alertmanager_storage_size" {
  description = "Tamanho do storage do Alertmanager"
  type        = string
  default     = "10Gi"
}
