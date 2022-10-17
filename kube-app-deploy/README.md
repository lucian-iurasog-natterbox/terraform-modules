<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_aws"></a> [aws](#requirement\_aws) (>= 4.20.0)

- <a name="requirement_helm"></a> [helm](#requirement\_helm) (>= 2.1.2)

- <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) (>= 2.7.1)

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (>= 4.20.0)

- <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) (>= 2.7.1)

## Modules

The following Modules are called:

### <a name="module_acm"></a> [acm](#module\_acm)

Source: git::ssh://git@bitbucket.redmatter.com/tf/terraform-modules//acm

Version: acm_0.0.1

## Resources

The following resources are used by this module:

- [aws_route53_record.app_domain_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) (resource)
- [kubernetes_deployment.deployment](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) (resource)
- [kubernetes_ingress_v1.k8s-ingress-rules-local](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) (resource)
- [kubernetes_ingress_v1.k8s-ingress-rules-ssl](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) (resource)
- [kubernetes_namespace.k8s_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) (resource)
- [kubernetes_secret.ecr_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) (resource)
- [kubernetes_secret.this_env_vars_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) (resource)
- [kubernetes_service.service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) (resource)
- [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) (data source)
- [aws_ecr_authorization_token.ecr_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_authorization_token) (data source)
- [aws_region.current_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) (data source)
- [aws_route53_zone.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) (data source)
- [kubernetes_ingress_v1.data_ingress_lb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/ingress_v1) (data source)
- [kubernetes_ingress_v1.data_ingress_rule_ssl](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/ingress_v1) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_ENVIRONMENT_VARIABLES"></a> [ENVIRONMENT\_VARIABLES](#input\_ENVIRONMENT\_VARIABLES)

Description: Application Environment variables map.

Type: `any`

### <a name="input_env"></a> [env](#input\_env)

Description: Environment Selector.

Type: `string`

### <a name="input_name"></a> [name](#input\_name)

Description: Deployment App Name

Type: `string`

### <a name="input_pod_image"></a> [pod\_image](#input\_pod\_image)

Description: Container Image

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone)

Description: Host to be set on the ingress rule.

Type: `string`

Default: `""`

### <a name="input_exposed_ports"></a> [exposed\_ports](#input\_exposed\_ports)

Description: Map of exposed ports.

Type:

```hcl
map(object(
    {
      container_listening_port          = number
      container_listening_port_protocol = string
    }
  ))
```

Default:

```json
{
  "443": {
    "container_listening_port": 80,
    "container_listening_port_protocol": "TCP"
  },
  "80": {
    "container_listening_port": 80,
    "container_listening_port_protocol": "TCP"
  }
}
```

### <a name="input_healthcheck_uri"></a> [healthcheck\_uri](#input\_healthcheck\_uri)

Description: ALB healthcheck uri.

Type: `string`

Default: `""`

### <a name="input_local_ingress_identifier"></a> [local\_ingress\_identifier](#input\_local\_ingress\_identifier)

Description: Minikube ingress app identifier, should be added in case of you want to deploy multiple different apps on the same minikube, also add this value to your local hosts file.

Type: `string`

Default: `""`

### <a name="input_number_of_replicas"></a> [number\_of\_replicas](#input\_number\_of\_replicas)

Description: Number of pod replicas set in the app deployment, default is set to 1.

Type: `number`

Default: `1`

## Outputs

The following outputs are exported:

### <a name="output_load_balancer_alb_hostname"></a> [load\_balancer\_alb\_hostname](#output\_load\_balancer\_alb\_hostname)

Description: ALB Hostname.

### <a name="output_load_balancer_alb_hostname_tls"></a> [load\_balancer\_alb\_hostname\_tls](#output\_load\_balancer\_alb\_hostname\_tls)

Description: FQDN CNAME pointing to ALB.

### <a name="output_load_balancer_ip"></a> [load\_balancer\_ip](#output\_load\_balancer\_ip)

Description: NGinx load balancer ip, also used for minikube local ip.
<!-- END_TF_DOCS -->
