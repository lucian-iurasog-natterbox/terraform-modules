<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 0.13.0)

- <a name="requirement_helm"></a> [helm](#requirement\_helm) (>= 2.1.2)

- <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) (>= 2.7.1)

## Providers

The following providers are used by this module:

- <a name="provider_helm"></a> [helm](#provider\_helm) (>= 2.1.2)

- <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) (>= 2.7.1)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [helm_release.this_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)
- [kubernetes_namespace.this_chart_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_charts"></a> [charts](#input\_charts)

Description: Map of charts parameters for the charts which are to be deployed.

Type:

```hcl
map(  object(
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
```

```hcl
//Example

{
      "prometheus" = {
        # enabled         = var.deploy_helmchart_prometheus_k8s
        name            = "prometheus"
        repository      = "https://prometheus-community.github.io/helm-charts"
        repo_chart_name = "prometheus"
        namespace       = "monitoring"
        version         = "v15.12.2"
        parameters = {
          "kubeEtcd.enabled" = {
            value = "true"
          }
          "kubeControllerManager.enabled" = {
            value = "true"
          }
          "kubeScheduler.enabled" = {
            value = "true"
          }
        }
        helm_release_optionals = {
            recreate_pods = true
            values = file("values.yaml") //if passed in variables.tfvars values should be the actual yaml content
        }
      }
}
```

## Optional Inputs

No optional inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
