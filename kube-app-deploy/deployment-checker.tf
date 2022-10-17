resource "kubernetes_config_map" "deployment_checker_cfm" {
  depends_on = [
    kubernetes_namespace.k8s_namespace
  ]
  metadata {
    name      = "deployment-checker-${var.name}"
    namespace = kubernetes_namespace.k8s_namespace.metadata.0.name
  }

  data = {
    "deployment-checker.sh" = <<-EOF
    #!/bin/bash

    while true; do
        sleep 60
        deployments=$(kubectl get deployments -n "${kubernetes_namespace.k8s_namespace.metadata.0.name}" --no-headers -o custom-columns=":metadata.name" | grep -v "${var.name}")
        echo "====== $(date) ======"
        for deployment in $${deployments}; do
            if ! kubectl rollout status deployment $${deployment} --timeout=10s 1>/dev/null 2>&1; then
                echo "Error: $${deployment} - rolling back!"
                kubectl rollout undo deployment $${deployment}
            else
                echo "Ok: $${deployment}"
            fi
        done
    done 
    EOF
  }
}

resource "kubernetes_service_account" "deployment_checker_srv_acct" {
  metadata {
    name      = "deployment-checker-${var.name}-sa"
    namespace = kubernetes_namespace.k8s_namespace.metadata.0.name
  }
}

resource "kubernetes_role_binding" "deployment_checker_rbac" {
  depends_on = [
    kubernetes_namespace.k8s_namespace,
    kubernetes_service_account.deployment_checker_srv_acct
  ]
  metadata {
    name      = "deployment-checker-${var.name}-rbac"
    namespace = kubernetes_namespace.k8s_namespace.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = "deployment-checker-${var.name}-sa"
    namespace = kubernetes_namespace.k8s_namespace.metadata.0.name
  }
  role_ref {
    kind      = "ClusterRole"
    name      = "edit"
    api_group = "rbac.authorization.k8s.io"
  }
}


resource "kubernetes_deployment" "deployment_checker" {
  depends_on = [
    kubernetes_namespace.k8s_namespace,
    kubernetes_config_map.deployment_checker_cfm,
    kubernetes_role_binding.deployment_checker_rbac
  ]
  metadata {
    name      = "deployment-checker-${var.name}"
    namespace = kubernetes_namespace.k8s_namespace.metadata.0.name
    labels = {
      app = "deployment-checker-${var.name}-deployment"
    }
  }
  spec {
    replicas = 2
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
        app = "deployment-checker-${var.name}"
      }
    }
    template {
      metadata {
        labels = {
          app = "deployment-checker-${var.name}"
        }
      }

      spec {
        service_account_name = "deployment-checker-${var.name}-sa"
        volume {
          name = "deployment-checker-${var.name}-volume"
          config_map {
            name = "deployment-checker-${var.name}"
          }
        }
        container {
          image             = "bitnami/kubectl"
          image_pull_policy = "IfNotPresent"
          name              = "deployment-checker-${var.name}"
          command           = ["bash", "/mnt/deployment-checker.sh"]
          volume_mount {
            name       = "deployment-checker-${var.name}-volume"
            mount_path = "/mnt"
          }
        }
      }
    }
  }
}
