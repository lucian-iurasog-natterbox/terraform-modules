# Terraform Modules

~ Dotcom Monitor

Specify the url in the **url_to_test** variable and add the required provider specifying the **UID**.
```
module "dotcommonitor" {
  source      = "git::ssh://git@bitbucket.redmatter.com/tf/terraform-modules.git//dotcommonitor"
  url_to_test = var.url_to_test # The url that will be tested
}
provider "dotcommonitor" {
  uid = var.DOTCOM_UID # DotCom Monitor UID
}
```
Required variables: 
> **url_to_test** and **DOTCOM_UID**.

Optional variables:  
> task_name, locations, platform_id, frequency, task_type_id, ssl_expiration_reminder_in_days,
device_name, request_type, time_shift_min, send_uptime_alert, false_positive_check, check_ssl_certificate_date,
check_ssl_certificate_authority, check_ssl_certificate_cn, dns_server_ip, deploy_filter

If you want to deploy a filter, the input should be an [""], if no, an empty []


[Dotcom Monitor Confluence Page](https://natterbox.atlassian.net/wiki/spaces/CO/pages/1083310143/Dotcom-monitor)
