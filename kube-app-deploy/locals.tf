locals {
  default_dns_zones = {
    "local" = ""
    "dev01" = "redmatter-dev01.pub"
    "dev02" = "redmatter-dev02.pub"
    "dev03" = "redmatter-dev03.pub"
    "dev04" = "redmatter-dev04.pub"
    "dev05" = "redmatter-dev05.pub"
    "qa01"  = "redmatter-qa01.pub"
    "qa02"  = "redmatter-qa02.pub"
    "stage" = "redmatter-dev01.pub"
    "prod"  = "redmatter-dev01.pub"
  }
  dns_env = { for x in [lower(var.dns_zone != "" ? var.dns_zone : local.default_dns_zones[var.env])] : var.env => x if var.env != "local" }
  aws_env = var.env != "local" ? var.env : ""
}

locals {
  healthcheck_port = kubernetes_service.service.spec.0.type == "NodePort" ? kubernetes_service.service.spec.0.port.0.node_port : kubernetes_service.service.spec.0.port.0.port
  healthcheck_uri  = var.healthcheck_uri == "" ? "/" : var.healthcheck_uri
}
