module "acm" {
  for_each    = try(local.dns_env, {})
  source      = "git::https://github.com/lucian-iurasog-natterbox/terraform-modules.git//acm?ref=acm_0.0.1"
  domain_name = "${var.name}.${each.value}"
}

resource "aws_route53_record" "app_domain_record" {
  for_each = try(local.dns_env, {})
  name     = lower(var.name)
  type     = "CNAME"
  zone_id  = data.aws_route53_zone.domain[each.key].id
  ttl      = 60
  records = [
    data.kubernetes_ingress_v1.data_ingress_rule_ssl[each.key].status.0.load_balancer.0.ingress.0.hostname
  ]
  depends_on = [
    module.acm.cert_domain_zone_id,
    kubernetes_ingress_v1.k8s-ingress-rules-ssl
  ]
}
