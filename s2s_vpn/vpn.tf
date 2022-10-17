resource "aws_customer_gateway" "this_customer_gw" {
  for_each   = var.customer_gateway_id == "" ? local.cgw : {}
  bgp_asn    = local.vpn_asn
  ip_address = each.value.cw_ip
  type       = each.value.cw_type

  tags = {
    Name   = "${var.vpc_name}-cgw-${var.vpn_dc}"
    DC     = var.vpn_dc
    Group  = "${var.vpc_name}-cgw"
    Region = data.aws_region.current_region.name
  }
}

resource "aws_vpn_connection" "this_vpn_connection_dynamic" {
  count               = contains(var.vpn_bgp_compatible_datacenters, var.vpn_dc) ? 1 : 0
  vpn_gateway_id      = var.vgw_id
  customer_gateway_id = try(aws_customer_gateway.this_customer_gw.0.id, var.customer_gateway_id)
  type                = var.customer_gateway_vpn_type
  tunnel1_inside_cidr = var.vpn_1_private_interconnect_cidrs
  tunnel2_inside_cidr = var.vpn_2_private_interconnect_cidrs


  tags = {
    Name   = "${var.vpc_name}-vpn-${var.vpn_dc}"
    DC     = var.vpn_dc
    Group  = "${var.vpc_name}-vpn"
    Region = data.aws_region.current_region.name
  }

  // This prevents the resource being destroyed either as part of an apply (for example, because the resource has been
  // removed from the config or has changed name) or through an explicit destroy.
  // While this doesn't really hold data, setting up a VPN does require manual setup on the legacy platform side, so
  // we'd rather avoid accidentally deleting these if possible.
  // If you're absolutely sure this resource can be destroyed safely then set the below variable to `false` and
  // re-attempt applying (or destroying) state.  Ensure you revert the change after, though, make sure it doesn't get
  // committed.
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_vpn_connection" "this_vpn_connection_static" {
  count               = !contains(var.vpn_bgp_compatible_datacenters, var.vpn_dc) ? 1 : 0
  vpn_gateway_id      = var.vgw_id
  customer_gateway_id = try(aws_customer_gateway.this_customer_gw.0.id, var.customer_gateway_id)
  type                = var.customer_gateway_vpn_type
  static_routes_only  = "true"

  tags = {
    Name   = "${var.vpc_name}-vpn-${var.vpn_dc}"
    DC     = var.vpn_dc
    Group  = "${var.vpc_name}-vpn"
    Region = data.aws_region.current_region.name
  }

  // This prevents the resource being destroyed either as part of an apply (for example, because the resource has been
  // removed from the config or has changed name) or through an explicit destroy.
  // While this doesn't really hold data, setting up a VPN does require manual setup on the legacy platform side, so
  // we'd rather avoid accidentally deleting these if possible.
  // If you're absolutely sure this resource can be destroyed safely then set the below variable to `false` and
  // re-attempt applying (or destroying) state.  Ensure you revert the change after, though, make sure it doesn't get
  // committed.
  lifecycle {
    prevent_destroy = false
  }
}

// Set up each route required, assigning it to the appropriate VPN connection for the DC.
resource "aws_vpn_connection_route" "this_vpn_connection_routes" {
  for_each               = !contains(var.vpn_bgp_compatible_datacenters, var.vpn_dc) ? toset(var.vpn_s2s_connection_routes) : []
  destination_cidr_block = each.value
  vpn_connection_id      = aws_vpn_connection.this_vpn_connection_static.0.id


  // Ensure new routes are created before the old ones are destroyed, to ensure we don't lose connectivity in the event
  // that routes are replaced.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpn_gateway_route_propagation" "static_route_propagation" {
  for_each = !contains(var.vpn_bgp_compatible_datacenters, var.vpn_dc) ? { for route_table in var.vpc_route_table_ids :
    "rts_ids" => {
      rt_id = route_table
    }
  } : {}
  vpn_gateway_id = var.vgw_id
  route_table_id = each.value.rt_id
}
