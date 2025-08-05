output "namespace" {
  description = "Namespace onde os recursos foram criados"
  value       = kubernetes_namespace.monitoring.metadata[0].name
}


output "prometheus_access" {
  description = "Como acessar o Prometheus"
  value = {
    port_forward = "kubectl port-forward svc/prometheus-kube-prometheus-prometheus 9090:9090 -n ${var.monitoring_namespace}"
    url          = "http://localhost:9090"
  }
}



output "grafana_access" {
  description = "Como acessar o Grafana"
  value = var.enable_ingress ? {
    url      = "https://${var.grafana_domain}"
    username = "admin"
    password = "Definida na variável grafana_admin_password"
    } : {
    service_command = "kubectl get svc grafana -n ${var.monitoring_namespace}"
    port_forward    = "kubectl port-forward svc/grafana 3000:80 -n ${var.monitoring_namespace}"
    username        = "admin"
    password        = "Definida na variável grafana_admin_password"
  }
}
