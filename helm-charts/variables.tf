variable "charts" {
  type = map(object(
    {
      # enabled         = bool
      name            = string
      repository      = string
      repo_chart_name = string
      namespace       = string
      version         = string
      parameters = map(object({
        value = string
      }))
      helm_release_optionals = map(any)
    }
  ))
  description = "Map of charts parameters for the charts which are to be deployed."
}

locals {
  # charts     = { for key in compact([for key, value in var.charts: value.enabled ? key : ""]): key => var.charts[key] }
  default_ns = ["default", "kube-node-lease", "kube-public", "kube-system"]
  charts     = var.charts
  namespaces = setsubtract(toset(flatten(distinct([for key, value in local.charts : var.charts[key].namespace]))), toset(local.default_ns))
}
