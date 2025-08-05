# Grafana

# Grafana Secret
resource "kubernetes_secret" "grafana_admin" {
  metadata {
    name      = "grafana"
    namespace = var.monitoring_namespace
  }

  data = {
    admin-user     = "admin"
    admin-password = var.grafana_admin_password
  }

  type = "Opaque"
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = "6.60.3"

  timeout       = 600 # 10 minutos
  wait          = true
  wait_for_jobs = true

  values = [
    yamlencode({
      # Usar secret existente criado pelo Terraform
      admin = {
        existingSecret = kubernetes_secret.grafana_admin.metadata[0].name
        userKey        = "admin-user"
        passwordKey    = "admin-password"
      }

      # Persistência habilitada com storage class flexível
      persistence = {
        enabled          = true
        storageClassName = "default"
        size             = var.grafana_storage_size
        accessModes      = ["ReadWriteOnce"]
      }

      # Service configurável

      service = {
        type = "LoadBalancer" # ← Sempre LoadBalancer
        port = 80
      }

      # Recursos otimizados
      resources = {
        limits = {
          cpu    = "500m"
          memory = "512Mi"
        }
        requests = {
          cpu    = "250m"
          memory = "256Mi"
        }
      }

      # Datasource pré-configurado
      datasources = {
        "datasources.yaml" = {
          apiVersion = 1
          datasources = [
            {
              name      = "Prometheus"
              type      = "prometheus"
              url       = "http://prometheus-kube-prometheus-prometheus:9090"
              access    = "proxy"
              isDefault = true
            }
          ]
        }
      }

      # Dashboard providers
      dashboardProviders = {
        "dashboardproviders.yaml" = {
          apiVersion = 1
          providers = [
            {
              name            = "default"
              orgId           = 1
              folder          = ""
              type            = "file"
              disableDeletion = false
              editable        = true
              options = {
                path = "/var/lib/grafana/dashboards/default"
              }
            }
          ]
        }
      }

      # Dashboards pré-configurados
      dashboards = {
        default = {
          kubernetes-cluster-dashboard = {
            gnetId     = 7249
            revision   = 1
            datasource = "Prometheus"
          }
          node-exporter-dashboard = {
            gnetId     = 1860
            revision   = 27
            datasource = "Prometheus"
          }
          kubernetes-pod-monitoring = {
            gnetId     = 6417
            revision   = 1
            datasource = "Prometheus"
          }
          aks-cluster-monitoring = {
            gnetId     = 8588
            revision   = 1
            datasource = "Prometheus"
          }
        }
      }

      # Environment variables
      env = {
        GF_USERS_ALLOW_SIGN_UP = "false"
        GF_SERVER_ROOT_URL     = var.enable_ingress ? "https://${var.grafana_domain}" : ""
      }

      # Security context
      securityContext = {
        runAsNonRoot = true
        runAsUser    = 472
        fsGroup      = 472
      }

      # Desabilitar testes que podem causar problemas
      testFramework = {
        enabled = false
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.monitoring,
    helm_release.prometheus,
    kubernetes_secret.grafana_admin # Garante que o secret existe antes
  ]
}
