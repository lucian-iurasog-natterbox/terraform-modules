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

- [aws_customer_gateway.this_customer_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) (resource)
- [aws_vpn_connection.this_vpn_connection_dynamic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) (resource)
- [aws_vpn_connection.this_vpn_connection_static](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) (resource)
- [aws_vpn_connection_route.this_vpn_connection_routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection_route) (resource)
- [aws_vpn_gateway_route_propagation.static_route_propagation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway_route_propagation) (resource)
- [aws_region.current_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_customer_gateway_vpn_ip"></a> [customer\_gateway\_vpn\_ip](#input\_customer\_gateway\_vpn\_ip)

Description: Public IP address to be used for VPN

Type: `string`

### <a name="input_env"></a> [env](#input\_env)

Description: Environment Selector.

Type: `string`

### <a name="input_vgw_id"></a> [vgw\_id](#input\_vgw\_id)

Description: VPN Gateway ID.

Type: `string`

### <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id)

Description: VPC id to be used by the VPN.

Type: `string`

### <a name="input_vpn_s2s_connection_routes"></a> [vpn\_s2s\_connection\_routes](#input\_vpn\_s2s\_connection\_routes)

Description: Network range of the DCs which should be routed to over the VPNs

Type: `list(string)`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_customer_gateway_id"></a> [customer\_gateway\_id](#input\_customer\_gateway\_id)

Description: ID of an existing customer gateway to use with each VPN, if specified it will not create a customer gateway.

Type: `string`

Default: `""`

### <a name="input_customer_gateway_vpn_asn"></a> [customer\_gateway\_vpn\_asn](#input\_customer\_gateway\_vpn\_asn)

Description: BGP ASNs to use with each VPN

Type: `string`

Default: `""`

### <a name="input_customer_gateway_vpn_type"></a> [customer\_gateway\_vpn\_type](#input\_customer\_gateway\_vpn\_type)

Description: The type of VPN connection; the only type AWS supports at this time is 'ipsec.1'

Type: `string`

Default: `"ipsec.1"`

### <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name)

Description: Name of the VPC, will be prefixed with other details such as the region

Type: `string`

Default: `"eks"`

### <a name="input_vpc_route_table_ids"></a> [vpc\_route\_table\_ids](#input\_vpc\_route\_table\_ids)

Description: Route Table IDs to be used for VGW route propagation, this should be set only for static routing.

Type: `list(string)`

Default: `[]`

### <a name="input_vpn_1_private_interconnect_cidrs"></a> [vpn\_1\_private\_interconnect\_cidrs](#input\_vpn\_1\_private\_interconnect\_cidrs)

Description: On-prem CIDR for tunnel 1 to be used with BGP.

Type: `string`

Default: `null`

### <a name="input_vpn_2_private_interconnect_cidrs"></a> [vpn\_2\_private\_interconnect\_cidrs](#input\_vpn\_2\_private\_interconnect\_cidrs)

Description: On-prem CIDR for tunnel 2 to be used with BGP.

Type: `string`

Default: `null`

### <a name="input_vpn_bgp_compatible_datacenters"></a> [vpn\_bgp\_compatible\_datacenters](#input\_vpn\_bgp\_compatible\_datacenters)

Description: List of datacenter codes compatible with BGP routing.

Type: `list(string)`

Default:

```json
[
  "T01",
  "T02",
  "S01",
  "T02"
]
```

### <a name="input_vpn_dc"></a> [vpn\_dc](#input\_vpn\_dc)

Description: Name of the DC which the VPN will connect to

Type: `string`

Default: `"LON"`

## Outputs

No outputs.
<!-- END_TF_DOCS -->
