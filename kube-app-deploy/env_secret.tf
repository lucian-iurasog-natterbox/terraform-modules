resource "kubernetes_secret" "this_env_vars_secret" {
  for_each = var.ENVIRONMENT_VARIABLES
  metadata {
    name      = lower(replace("env-${var.name}-${each.key}", "_", "-"))
    namespace = kubernetes_namespace.k8s_namespace.metadata.0.name
  }
  type = "Opaque"
  data = { "${each.key}" = "${each.value}" }
}
