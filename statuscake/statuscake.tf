resource "statuscake_uptime_check" "this_uptime_check" {
  for_each       = var.uptime_check_address != "" ? toset([""]) : []
  name           = var.uptime_check_name
  check_interval = var.uptime_check_interval
  confirmation   = var.confirmation
  trigger_rate   = var.trigger_rate
  contact_groups = var.contact_groups[var.env]

  http_check {
    enable_cookies   = var.enable_cookies
    follow_redirects = var.follow_redirects
    timeout          = var.timeout
    user_agent       = var.user_agent
    validate_ssl     = var.validate_ssl

    basic_authentication {
      username = var.username
      password = var.password
    }

    dynamic "content_matchers" {
      for_each = var.content == "" ? toset([]) : toset([1])
      content {
        content         = var.content
        include_headers = var.include_headers
        matcher         = var.matcher
      }
    }
    request_headers = var.request_headers
    status_codes    = var.status_codes
  }
  monitored_resource {
    address = var.uptime_check_address
  }
  regions = var.regions
  tags    = var.tags
}

resource "statuscake_pagespeed_check" "this_pagespeed_check" {
  for_each       = var.pagespeed_check_address != "" ? toset([""]) : []
  name           = var.pagespeed_check_name
  check_interval = var.pagespeed_check_interval
  region         = var.region
  contact_groups = var.contact_groups[var.env]

  alert_config {
    alert_bigger  = var.alert_bigger
    alert_slower  = var.alert_slower
    alert_smaller = var.alert_smaller
  }

  monitored_resource {
    address = var.pagespeed_check_address
  }
}

resource "statuscake_ssl_check" "this_ssl_check" {
  for_each       = var.ssl_check_address != "" ? toset([""]) : []
  check_interval = var.ssl_check_interval
  user_agent     = var.user_agent
  contact_groups = var.contact_groups[var.env]

  alert_config {
    alert_at    = var.alert_at
    on_reminder = var.on_reminder
    on_expiry   = var.on_expiry
    on_broken   = var.on_broken
    on_mixed    = var.on_mixed
  }

  monitored_resource {
    address = var.ssl_check_address
  }
}
