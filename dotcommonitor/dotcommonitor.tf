# Creates a Dotcom-monitor device to run tasks
resource "dotcommonitor_device" "this_device" {
  name                 = var.device_name
  locations            = var.locations
  platform_id          = var.platform_id
  frequency            = var.frequency
  send_uptime_alert    = var.send_uptime_alert
  false_positive_check = var.false_positive_check
  filter_id            = var.deploy_filter == [] ? resource.dotcommonitor_filter.this_filter[""].id : 0

  dynamic "notifications_groups" {
    for_each = data.dotcommonitor_group.this_notifications_groups
    content {
      id             = notifications_groups.value.id
      time_shift_min = var.time_shift_min
    }
  }
}
# Creates a Dotcom-monitor task to test the url
resource "dotcommonitor_task" "this_task" {
  device_id                       = dotcommonitor_device.this_device.id
  request_type                    = var.request_type
  url                             = var.url_to_test
  name                            = var.task_name
  task_type_id                    = var.task_type_id
  ssl_check_certificate_date      = var.check_ssl_certificate_date
  ssl_check_certificate_authority = var.check_ssl_certificate_authority
  ssl_check_certificate_cn        = var.check_ssl_certificate_cn
  ssl_expiration_reminder_in_days = var.ssl_expiration_reminder_in_days
}

resource "dotcommonitor_filter" "this_filter" {
  for_each = try(var.deploy_filter, {})
  name     = var.filter_name
  rules {
    num_locations     = var.filter_num_locations
    num_tasks         = var.filter_num_tasks
    owner_device_down = var.owner_device_down
  }
  ignore_errors {
    type  = var.filter_type
    codes = var.filter_code
  }
}

data "dotcommonitor_group" "this_notifications_groups" {
  for_each = tomap(var.notifications_groups[var.env])
  name     = each.value.name
}
