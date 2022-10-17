output "this_uptime_check_id" {
  value       = var.uptime_check_address != "" ? statuscake_uptime_check.this_uptime_check[""].id : null
  description = "The id of the uptime check"
}

output "this_ssl_check_id" {
  value       = var.ssl_check_address != "" ? statuscake_ssl_check.this_ssl_check[""].id : null
  description = "The id of the ssl check"
}

output "this_pagespeed_check_id" {
  value       = var.pagespeed_check_address != "" ? statuscake_pagespeed_check.this_pagespeed_check[""].id : null
  description = "The id of the pagespeed check"
}
