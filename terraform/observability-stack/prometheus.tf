resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.monitoring_namespace
    labels = {
      name = var.monitoring_namespace
    }
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = "51.3.0"

  values = [
    yamlencode({
      prometheus = {
        prometheusSpec = {
          retention = var.prometheus_retention
           additionalScrapeConfigs = [
            {
              job_name = "meu-website"
              static_configs = [
                {
                  targets = ["meu-website:80"]
                }
              ]
              metrics_path = "/metrics"
            }
          ]
          storageSpec = {
            volumeClaimTemplate = {
              spec = {
                storageClassName = "managed-csi"
                accessModes      = ["ReadWriteOnce"]
                resources = {
                  requests = {
                    storage = var.prometheus_storage_size
                  }
                }
              }
            }
          }
          resources = {
            limits = {
              cpu    = "1000m"
              memory = "2Gi"
            }
            requests = {
              cpu    = "500m"
              memory = "1Gi"
            }
          }
        }
        service = {
          type = "LoadBalancer"
        }
      }

      alertmanager = {
        alertmanagerSpec = {
          storage = {
            volumeClaimTemplate = {
              spec = {
                storageClassName = "managed-csi"
                accessModes      = ["ReadWriteOnce"]
                resources = {
                  requests = {
                    storage = var.alertmanager_storage_size
                  }
                }
              }
            }
          }
          resources = {
            limits = {
              cpu    = "200m"
              memory = "256Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
          }
        }
        service = {
          type = "ClusterIP"
          port = 9093
        }
      }

      grafana = {
        enabled = false # Instalamos o Grafana separadamente
      }

      nodeExporter = {
        enabled = true
      }

      kubeStateMetrics = {
        enabled = true
      }

      prometheusOperator = {
        enabled = true
        resources = {
          limits = {
            cpu    = "200m"
            memory = "200Mi"
          }
          requests = {
            cpu    = "100m"
            memory = "100Mi"
          }
        }
      }

      # Configurações específicas para AKS
      kubelet = {
        enabled   = true
        namespace = "kube-system"
      }
    })
  ]

  depends_on = [kubernetes_namespace.monitoring]
}
