locals {
  pgw_asn_hAPI_LocID = {
    S01 = "02"
    S02 = "01"
    LON = "03"
    CRO = "04"
    G01 = "10"
    G02 = "12"
    G03 = "14"
    G04 = "20"
    G05 = "22"
  }
  pgw_asn_hAPI_LocID_stg = merge({
    T01 = "01"
    T02 = "02"
  }, local.pgw_asn_hAPI_LocID)
  pgw_asn_a_list = {
    dev01 = "9"
    dev02 = "9"
    dev03 = "9"
    dev04 = "9"
    dev05 = "9"
    qa01  = "8"
    qa02  = "8"
    stage = "7"
    prod  = "6"
  }
  asn_a   = local.pgw_asn_a_list[var.env]
  asn_bb  = substr(var.env, 0, length("stage")) == "stage" && contains(["T01", "T02"], upper(var.vpn_dc)) ? local.pgw_asn_hAPI_LocID_stg[var.vpn_dc] : local.pgw_asn_hAPI_LocID[var.vpn_dc]
  pgw_asn = "64${local.asn_a}${local.asn_bb}"
  vpn_asn = var.customer_gateway_vpn_asn == "" ? local.pgw_asn : var.customer_gateway_vpn_asn
  cgw = {
    cgw0 = {
      cw_ip   = var.customer_gateway_vpn_ip
      cw_type = var.customer_gateway_vpn_type
    }
  }
}
