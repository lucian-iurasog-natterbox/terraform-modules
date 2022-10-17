<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_aws"></a> [aws](#requirement\_aws) (>= 3.0)

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (>= 3.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [aws_acm_certificate.this_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) (resource)
- [aws_acm_certificate_validation.this_acm_cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) (resource)
- [aws_route53_record.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) (resource)
- [aws_route53_zone.this_getzoneid_if_exists](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name)

Description: Fully Qualified Domain Name (FQDN) for which to issue the certificate.

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_cert_arn"></a> [cert\_arn](#output\_cert\_arn)

Description: Certificate ARN.

### <a name="output_cert_fqdn"></a> [cert\_fqdn](#output\_cert\_fqdn)

Description: Certificate FQDN.

### <a name="output_cert_fqdn_zone_id"></a> [cert\_fqdn\_zone\_id](#output\_cert\_fqdn\_zone\_id)

Description: Domain Route 53 Zone ID.

### <a name="output_cert_fqdn_zone_name"></a> [cert\_fqdn\_zone\_name](#output\_cert\_fqdn\_zone\_name)

Description: Domain Route 53 Zone Name.

### <a name="output_cert_status"></a> [cert\_status](#output\_cert\_status)

Description: Certificate Status.
<!-- END_TF_DOCS -->
