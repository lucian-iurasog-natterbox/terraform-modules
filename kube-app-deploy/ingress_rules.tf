resource "kubernetes_ingress_v1" "k8s-ingress-rules-local" {
  count                  = var.env == "local" ? 1 : 0
  wait_for_load_balancer = true
  metadata {
    name      = "${var.name}-ingress"
    namespace = kubernetes_namespace.k8s_namespace.metadata.0.name
    annotations = {
      "kubernetes.io/ingress.class"              = "nginx"
      "nginx.ingress.kubernetes.io/use-regex"    = "true"
      "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
    }
  }
  spec {
    rule {
      host = var.local_ingress_identifier
      http {
        path {
          backend {
            service {
              name = var.name
              port {
                number = 80
              }
            }
          }
          path      = "/"
          path_type = "Prefix"
        }
      }
    }
  }
  depends_on = [
    kubernetes_service.service
  ]
}


resource "kubernetes_ingress_v1" "k8s-ingress-rules-ssl" {
  for_each               = try(local.dns_env, {})
  wait_for_load_balancer = true
  metadata {
    name      = "${var.name}-ingress-ssl"
    namespace = kubernetes_namespace.k8s_namespace.metadata.0.name
    annotations = {
      "kubernetes.io/ingress.class"                            = "alb"
      "alb.ingress.kubernetes.io/scheme"                       = "internet-facing"
      "alb.ingress.kubernetes.io/certificate-arn"              = "${module.acm[each.key].cert_arn}"
      "alb.ingress.kubernetes.io/load-balancer-name"           = "${var.name}"
      "alb.ingress.kubernetes.io/listen-ports"                 = "[{\"HTTPS\":80},{\"HTTPS\":443}]"
      "alb.ingress.kubernetes.io/ssl-redirect"                 = "443"
      "alb.ingress.kubernetes.io/healthcheck-port"             = "${local.healthcheck_port}"
      "alb.ingress.kubernetes.io/healthcheck-protocol"         = "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-path"             = "${local.healthcheck_uri}"
      "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = 15
      "alb.ingress.kubernetes.io/healthcheck-timeout-seconds"  = 2
      "alb.ingress.kubernetes.io/healthy-threshold-count"      = 5
      "alb.ingress.kubernetes.io/unhealthy-threshold-count"    = 5
      "alb.ingress.kubernetes.io/success-codes"                = "200"
      "alb.ingress.kubernetes.io/backend-protocol"             = "HTTP"
      "alb.ingress.kubernetes.io/backend-protocol-version"     = "HTTP1"

    }
  }
  spec {
    rule {
      host = "${var.name}.${each.value}"
      http {
        path {
          backend {
            service {
              name = var.name
              port {
                number = 80
              }
            }
          }
          path      = "/"
          path_type = "Prefix"
        }
      }
    }
    tls {
      hosts = ["${var.name}.${each.value}"]
    }
  }
  depends_on = [
    kubernetes_service.service,
    module.acm
  ]
}
