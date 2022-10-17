################################################################################
# AWS ACCOUNT DETAILS
################################################################################

data "aws_caller_identity" "current" {}
data "aws_region" "current_region" {}

################################################################################
# KUBE INGRESS
################################################################################

data "kubernetes_ingress_v1" "data_ingress_lb" {
  count = var.env == "local" ? 1 : 0
  metadata {
    name      = kubernetes_ingress_v1.k8s-ingress-rules-local[count.index].metadata.0.name
    namespace = kubernetes_ingress_v1.k8s-ingress-rules-local[count.index].metadata.0.namespace
  }
}

data "kubernetes_ingress_v1" "data_ingress_rule_ssl" {
  for_each = try(local.dns_env, {})
  metadata {
    name      = kubernetes_ingress_v1.k8s-ingress-rules-ssl[each.key].metadata.0.name
    namespace = kubernetes_ingress_v1.k8s-ingress-rules-ssl[each.key].metadata.0.namespace
  }
}

################################################################################
# ROUTE 53 QUERY
################################################################################

data "aws_route53_zone" "domain" {
  for_each = try(local.dns_env, {})
  name     = "${each.value}."
}
