resource "kubernetes_namespace" "k8s_namespace" {
  metadata {
    name = var.name
  }
}

resource "kubernetes_deployment" "deployment" {
  depends_on = [
    kubernetes_namespace.k8s_namespace,
    kubernetes_secret.ecr_secret,
    kubernetes_secret.this_env_vars_secret
  ]
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.k8s_namespace.metadata.0.name
    labels = {
      app = "${var.name}-deployment"
    }
  }
  spec {
    replicas               = var.number_of_replicas
    revision_history_limit = 15
    strategy {
      ##  type in [Recreate, RollingUpdate]
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "0"
        max_unavailable = "20%"
      }
    }
    selector {
      match_labels = {
        app = "${var.name}"
      }
    }
    template {
      metadata {
        labels = {
          app = "${var.name}"
        }
      }

      spec {
        image_pull_secrets {
          name = "aws-ecr-docker-config"
        }
        container {
          image             = var.pod_image
          image_pull_policy = "Always"
          name              = var.name
          ####################################
          dynamic "env" {
            for_each = var.ENVIRONMENT_VARIABLES
            content {
              name = env.key
              value_from {
                secret_key_ref {
                  name = lower(replace("env-${var.name}-${env.key}", "_", "-"))
                  key  = env.key
                }
              }
            }
          }
          dynamic "port" {
            for_each = var.exposed_ports
            content {
              container_port = port.value.container_listening_port
              protocol       = port.value.container_listening_port_protocol
            }
          }
          resources {
            requests = {
              cpu    = "500m"
              memory = "1Gi"
            }
            limits = {
              cpu    = "1000m"
              memory = "1Gi"
            }
          }
          # liveness_probe {
          #   http_get {
          #     path = "/v1/test/unsecure"
          #     port = 80
          #     scheme = "HTTP"
          #   }
          #   initial_delay_seconds = 3
          #   period_seconds        = 3
          # }
        }
      }
    }
  }
}
