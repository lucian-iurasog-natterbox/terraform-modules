
locals {

}

resource "kubernetes_namespace" "this_chart_namespace" {
  for_each = try(local.namespaces, {})
  metadata {
    name = each.value
  }
}

resource "helm_release" "this_release" {
  for_each         = try(local.charts, {})
  atomic           = lookup(each.value.helm_release_optionals, "atomic", "false")
  name             = lookup(local.charts[each.key], "name", each.key)
  namespace        = lookup(local.charts[each.key], "namespace", "${each.key}-ns")
  create_namespace = lookup(each.value.helm_release_optionals, "create_namespace", "false")

  lint                       = lookup(each.value.helm_release_optionals, "lint", "false")
  max_history                = lookup(each.value.helm_release_optionals, "max_history", 0)
  pass_credentials           = lookup(each.value.helm_release_optionals, "pass_credentials", "false")
  repository                 = lookup(local.charts[each.key], "repository", "")
  chart                      = lookup(local.charts[each.key], "repo_chart_name", "")
  version                    = lookup(local.charts[each.key], "version", "")
  verify                     = lookup(each.value.helm_release_optionals, "verify", "false")
  force_update               = lookup(each.value.helm_release_optionals, "force_update", "false")
  replace                    = lookup(each.value.helm_release_optionals, "replace", "false")
  recreate_pods              = lookup(each.value.helm_release_optionals, "recreate_pods", "false")
  render_subchart_notes      = lookup(each.value.helm_release_optionals, "render_subchart_notes", "true")
  skip_crds                  = lookup(each.value.helm_release_optionals, "skip_crds", "false")
  reset_values               = lookup(each.value.helm_release_optionals, "reset_values", "false")
  reuse_values               = lookup(each.value.helm_release_optionals, "reuse_values", "false")
  dependency_update          = lookup(each.value.helm_release_optionals, "dependency_update", "false")
  disable_crd_hooks          = lookup(each.value.helm_release_optionals, "disable_crd_hooks", "false")
  disable_openapi_validation = lookup(each.value.helm_release_optionals, "disable_openapi_validation", "false")
  disable_webhooks           = lookup(each.value.helm_release_optionals, "disable_webhooks", "false")
  values                     = [lookup(each.value.helm_release_optionals, "values", "")]
  dynamic "set" {
    for_each = try(each.value.parameters, {})
    content {
      name  = set.key
      value = set.value.value
    }
  }
  cleanup_on_fail = lookup(each.value.helm_release_optionals, "cleanup_on_fail", "true")
  wait            = lookup(each.value.helm_release_optionals, "wait", "true")
  wait_for_jobs   = lookup(each.value.helm_release_optionals, "wait_for_jobs", "false")
  timeout         = lookup(each.value.helm_release_optionals, "timeout", "300")
  depends_on      = [kubernetes_namespace.this_chart_namespace]
}
