<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_statuscake"></a> [statuscake](#requirement\_statuscake) | 2.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_statuscake"></a> [statuscake](#provider\_statuscake) | 2.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [statuscake_pagespeed_check.this_pagespeed_check](https://registry.terraform.io/providers/StatusCakeDev/statuscake/2.0.4/docs/resources/pagespeed_check) | resource |
| [statuscake_ssl_check.this_ssl_check](https://registry.terraform.io/providers/StatusCakeDev/statuscake/2.0.4/docs/resources/ssl_check) | resource |
| [statuscake_uptime_check.this_uptime_check](https://registry.terraform.io/providers/StatusCakeDev/statuscake/2.0.4/docs/resources/uptime_check) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_at"></a> [alert\_at](#input\_alert\_at) | List representing when alerts should be sent (days). Must be exactly 3 numerical values | `set(number)` | <pre>[<br>  7,<br>  14,<br>  21<br>]</pre> | no |
| <a name="input_alert_bigger"></a> [alert\_bigger](#input\_alert\_bigger) | An alert will be sent if the size of the page is larger than this value (kb) | `number` | `5000` | no |
| <a name="input_alert_slower"></a> [alert\_slower](#input\_alert\_slower) | An alert will be sent if the load time of the page exceeds this value (ms) | `number` | `4000` | no |
| <a name="input_alert_smaller"></a> [alert\_smaller](#input\_alert\_smaller) | An alert will be sent if the size of the page is smaller than this value (kb) | `number` | `1000` | no |
| <a name="input_confirmation"></a> [confirmation](#input\_confirmation) | Number of confirmation servers to confirm downtime before an alert is triggered | `number` | `3` | no |
| <a name="input_contact_groups"></a> [contact\_groups](#input\_contact\_groups) | contact\_group details | `map(set(string))` | <pre>{<br>  "dev01": [<br>    "271113"<br>  ],<br>  "dev02": [<br>    "271113"<br>  ],<br>  "dev03": [<br>    "271113"<br>  ],<br>  "dev04": [<br>    "271113"<br>  ],<br>  "dev05": [<br>    "271113"<br>  ],<br>  "prod": [<br>    "271120"<br>  ],<br>  "qa01": [<br>    "271114"<br>  ],<br>  "qa02": [<br>    "271114"<br>  ],<br>  "stage": [<br>    "271115"<br>  ]<br>}</pre> | no |
| <a name="input_content"></a> [content](#input\_content) | String to look for within the response. Considered down if not found | `string` | `""` | no |
| <a name="input_enable_cookies"></a> [enable\_cookies](#input\_enable\_cookies) | Whether to enable cookie storage | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | `"The environment"` | no |
| <a name="input_follow_redirects"></a> [follow\_redirects](#input\_follow\_redirects) | Whether to follow redirects when testing | `bool` | `false` | no |
| <a name="input_include_headers"></a> [include\_headers](#input\_include\_headers) | Include header content in string match search | `bool` | `true` | no |
| <a name="input_matcher"></a> [matcher](#input\_matcher) | Whether to consider the check as down if the content is present within the response (CONTAINS\_STRING, NOT\_CONTAINS\_STRING) | `string` | `"NOT_CONTAINS_STRING"` | no |
| <a name="input_on_broken"></a> [on\_broken](#input\_on\_broken) | Whether to enable alerts when SSL certificate issues are found | `bool` | `false` | no |
| <a name="input_on_expiry"></a> [on\_expiry](#input\_on\_expiry) | Whether to enable alerts when the SSL certificate is to expire | `bool` | `true` | no |
| <a name="input_on_mixed"></a> [on\_mixed](#input\_on\_mixed) | Whether to enable alerts when mixed content is found | `bool` | `false` | no |
| <a name="input_on_reminder"></a> [on\_reminder](#input\_on\_reminder) | Whether to enable alert reminders | `bool` | `true` | no |
| <a name="input_pagespeed_check_address"></a> [pagespeed\_check\_address](#input\_pagespeed\_check\_address) | URL or IP address of the website under test | `string` | `""` | no |
| <a name="input_pagespeed_check_interval"></a> [pagespeed\_check\_interval](#input\_pagespeed\_check\_interval) | Number of seconds between checks | `number` | `300` | no |
| <a name="input_pagespeed_check_name"></a> [pagespeed\_check\_name](#input\_pagespeed\_check\_name) | Name of the check | `string` | `"Pagespeed test"` | no |
| <a name="input_password"></a> [password](#input\_password) | Authentication password | `string` | `"password"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region on which to run checks | `string` | `"UK"` | no |
| <a name="input_regions"></a> [regions](#input\_regions) | List of regions on which to run checks | `list(string)` | <pre>[<br>  "london",<br>  "paris"<br>]</pre> | no |
| <a name="input_request_headers"></a> [request\_headers](#input\_request\_headers) | Represents headers to be sent when making requests | `map(string)` | <pre>{<br>  "Authorization": "bearer 123456"<br>}</pre> | no |
| <a name="input_ssl_check_address"></a> [ssl\_check\_address](#input\_ssl\_check\_address) | URL of the server under test | `string` | `""` | no |
| <a name="input_ssl_check_interval"></a> [ssl\_check\_interval](#input\_ssl\_check\_interval) | Number of seconds between checks | `number` | `600` | no |
| <a name="input_status_codes"></a> [status\_codes](#input\_status\_codes) | List of status codes that trigger an alert | `set(string)` | <pre>[<br>  "202",<br>  "404",<br>  "405"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags | `set(string)` | <pre>[<br>  "development"<br>]</pre> | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The number of seconds to wait to receive the first byte | `number` | `20` | no |
| <a name="input_trigger_rate"></a> [trigger\_rate](#input\_trigger\_rate) | The number of minutes to wait before sending an alert | `number` | `10` | no |
| <a name="input_uptime_check_address"></a> [uptime\_check\_address](#input\_uptime\_check\_address) | URL, FQDN, or IP address of the server under test | `string` | `""` | no |
| <a name="input_uptime_check_interval"></a> [uptime\_check\_interval](#input\_uptime\_check\_interval) | Number of seconds between checks | `number` | `30` | no |
| <a name="input_uptime_check_name"></a> [uptime\_check\_name](#input\_uptime\_check\_name) | Name of the check | `string` | `"Uptime test"` | no |
| <a name="input_user_agent"></a> [user\_agent](#input\_user\_agent) | Custom user agent string set when testing | `string` | `"terraform managed uptime check"` | no |
| <a name="input_username"></a> [username](#input\_username) | Authentication username | `string` | `"username"` | no |
| <a name="input_validate_ssl"></a> [validate\_ssl](#input\_validate\_ssl) | Whether to send an alert if the SSL certificate is soon to expire | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_pagespeed_check_id"></a> [this\_pagespeed\_check\_id](#output\_this\_pagespeed\_check\_id) | The id of the pagespeed check |
| <a name="output_this_ssl_check_id"></a> [this\_ssl\_check\_id](#output\_this\_ssl\_check\_id) | The id of the ssl check |
| <a name="output_this_uptime_check_id"></a> [this\_uptime\_check\_id](#output\_this\_uptime\_check\_id) | The id of the uptime check |
<!-- END_TF_DOCS -->
