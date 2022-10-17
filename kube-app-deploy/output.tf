output "load_balancer_ip" {
  value       = var.env == "local" ? data.kubernetes_ingress_v1.data_ingress_lb.0.status != null ? data.kubernetes_ingress_v1.data_ingress_lb.0.status.0.load_balancer.0.ingress.0.ip : "" : ""
  description = "NGinx load balancer ip, also used for minikube local ip."
}

output "load_balancer_alb_hostname" {
  value       = var.env != "local" ? data.kubernetes_ingress_v1.data_ingress_rule_ssl[local.aws_env].status != null ? data.kubernetes_ingress_v1.data_ingress_rule_ssl[local.aws_env].status.0.load_balancer.0.ingress.0.hostname : "" : ""
  description = "ALB Hostname."
}

output "load_balancer_alb_hostname_tls" {
  value       = var.env != "local" ? data.kubernetes_ingress_v1.data_ingress_rule_ssl[local.aws_env].status != null ? aws_route53_record.app_domain_record[var.env].fqdn : "" : ""
  description = "FQDN CNAME pointing to ALB."
}
