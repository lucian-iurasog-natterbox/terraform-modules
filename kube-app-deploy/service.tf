resource "kubernetes_service" "service" {
  depends_on = [kubernetes_deployment.deployment]
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.k8s_namespace.metadata.0.name
  }
  spec {
    selector = {
      app = "${var.name}"
    }
    type             = "NodePort"
    session_affinity = "ClientIP"
    dynamic "port" {
      for_each = var.exposed_ports
      content {
        name        = "${var.name}-port-${port.key}"
        port        = port.key
        target_port = port.value.container_listening_port
        protocol    = port.value.container_listening_port_protocol
      }
    }
  }
}
