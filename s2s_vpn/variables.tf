variable "env" {
  type        = string
  description = "Environment Selector."
  validation {
    condition     = contains(["dev01", "dev02", "dev03", "dev04", "dev05", "qa01", "qa02", "stg", "prod"], var.env)
    error_message = "Valid values for var: env are (dev01,dev02,dev03,dev04,dev05,qa01,qa02,stg,prod)."
  }
}
#######################################################
# VPC
#######################################################

variable "vpc_id" {
  type        = string
  description = "VPC id to be used by the VPN."
}

variable "vpc_name" {
  default     = "eks"
  description = "Name of the VPC, will be prefixed with other details such as the region"
}

variable "vpn_dc" {
  type        = string
  default     = "LON"
  description = "Name of the DC which the VPN will connect to"
  validation {
    condition     = contains(["T01", "T02", "S01", "S02", "LON", "CRO", "G01", "G02", "G03", "G04", "G05"], var.vpn_dc)
    error_message = "Valid values for var: vpn_dc are (T01,T02,S01,S02,LON,CRO,G01,G02,G03,G04,G05)."
  }
}

variable "vgw_id" {
  type        = string
  description = "VPN Gateway ID."
}

variable "customer_gateway_vpn_ip" {
  type        = string
  description = "Public IP address to be used for VPN"
}

variable "customer_gateway_vpn_asn" {
  type        = string
  default     = ""
  description = "BGP ASNs to use with each VPN"
}

variable "customer_gateway_id" {
  type        = string
  default     = ""
  description = "ID of an existing customer gateway to use with each VPN, if specified it will not create a customer gateway."
}

variable "customer_gateway_vpn_type" {
  default     = "ipsec.1"
  description = "The type of VPN connection; the only type AWS supports at this time is 'ipsec.1'"
}

variable "vpn_s2s_connection_routes" {
  type        = list(string)
  description = "Network range of the DCs which should be routed to over the VPNs"
}

variable "vpn_bgp_compatible_datacenters" {
  type        = list(string)
  description = "List of datacenter codes compatible with BGP routing."
  default = [
    "T01",
    "T02",
    "S01",
    "T02",
  ]
}

variable "vpn_1_private_interconnect_cidrs" {
  type        = string
  description = "On-prem CIDR for tunnel 1 to be used with BGP."
  default     = null
}

variable "vpn_2_private_interconnect_cidrs" {
  type        = string
  description = "On-prem CIDR for tunnel 2 to be used with BGP."
  default     = null
}

variable "vpc_route_table_ids" {
  type        = list(string)
  default     = []
  description = "Route Table IDs to be used for VGW route propagation, this should be set only for static routing."
}
