variable "contact_groups" {
  type        = map(set(string))
  description = "contact_group details"
  default = {
    dev01 = ["271113"]
    dev02 = ["271113"]
    dev03 = ["271113"]
    dev04 = ["271113"]
    dev05 = ["271113"]
    qa01  = ["271114"]
    qa02  = ["271114"]
    stage = ["271115"]
    prod  = ["271120"]
  }
}

variable "env" {
  type    = string
  default = "The environment"
}

variable "uptime_check_name" {
  type        = string
  description = "Name of the check"
  default     = "Uptime test"
}
variable "uptime_check_interval" {
  type        = number
  description = "Number of seconds between checks"
  default     = 30
}
variable "confirmation" {
  type        = number
  description = "Number of confirmation servers to confirm downtime before an alert is triggered"
  default     = 3
}
variable "trigger_rate" {
  type        = number
  description = "The number of minutes to wait before sending an alert"
  default     = 10
}
variable "enable_cookies" {
  type        = bool
  description = "Whether to enable cookie storage"
  default     = true
}
variable "follow_redirects" {
  type        = bool
  description = "Whether to follow redirects when testing"
  default     = false
}
variable "timeout" {
  type        = number
  description = "The number of seconds to wait to receive the first byte"
  default     = 20
}
variable "user_agent" {
  type        = string
  description = "Custom user agent string set when testing"
  default     = "terraform managed uptime check"
}
variable "validate_ssl" {
  type        = bool
  description = "Whether to send an alert if the SSL certificate is soon to expire"
  default     = true
}
variable "username" {
  type        = string
  description = "Authentication username"
  default     = "username"
}
variable "password" {
  type        = string
  description = "Authentication password"
  default     = "password"
}
variable "content" {
  type        = string
  description = "String to look for within the response. Considered down if not found"
  default     = ""
}
variable "include_headers" {
  type        = bool
  description = "Include header content in string match search"
  default     = true
}
variable "matcher" {
  type        = string
  description = "Whether to consider the check as down if the content is present within the response (CONTAINS_STRING, NOT_CONTAINS_STRING)"
  default     = "NOT_CONTAINS_STRING"
  validation {
    condition     = contains(["CONTAINS_STRING", "NOT_CONTAINS_STRING"], var.matcher)
    error_message = "Matcher value should be one of the values (CONTAINS_STRING, NOT_CONTAINS_STRING)"
  }
}
variable "request_headers" {
  type        = map(string)
  description = "Represents headers to be sent when making requests"
  default     = { Authorization = "bearer 123456" }
}
variable "status_codes" {
  type        = set(string)
  description = "List of status codes that trigger an alert"
  default     = ["202", "404", "405", ]
}
variable "uptime_check_address" {
  type        = string
  description = "URL, FQDN, or IP address of the server under test"
  default     = ""
}
variable "regions" {
  type        = list(string)
  description = "List of regions on which to run checks"
  default     = ["london", "paris", ]
}
variable "tags" {
  type        = set(string)
  description = "List of tags"
  default     = ["development"]
}
variable "pagespeed_check_name" {
  type        = string
  description = "Name of the check"
  default     = "Pagespeed test"
}
variable "pagespeed_check_interval" {
  type        = number
  description = "Number of seconds between checks"
  default     = 300
}
variable "region" {
  type        = string
  description = "Region on which to run checks"
  default     = "UK"
}
variable "alert_bigger" {
  type        = number
  description = "An alert will be sent if the size of the page is larger than this value (kb)"
  default     = 5000
}
variable "alert_slower" {
  type        = number
  description = "An alert will be sent if the load time of the page exceeds this value (ms)"
  default     = 4000
}
variable "alert_smaller" {
  type        = number
  description = "An alert will be sent if the size of the page is smaller than this value (kb)"
  default     = 1000
}
variable "pagespeed_check_address" {
  type        = string
  description = "URL or IP address of the website under test"
  default     = ""
}
variable "ssl_check_interval" {
  type        = number
  description = "Number of seconds between checks"
  default     = 600
}
variable "alert_at" {
  type        = set(number)
  description = "List representing when alerts should be sent (days). Must be exactly 3 numerical values"
  default     = [7, 14, 21]
}
variable "on_reminder" {
  type        = bool
  description = "Whether to enable alert reminders"
  default     = true
}
variable "on_expiry" {
  type        = bool
  description = "Whether to enable alerts when the SSL certificate is to expire"
  default     = true
}
variable "on_broken" {
  type        = bool
  description = "Whether to enable alerts when SSL certificate issues are found"
  default     = false
}
variable "on_mixed" {
  type        = bool
  description = "Whether to enable alerts when mixed content is found"
  default     = false
}
variable "ssl_check_address" {
  type        = string
  description = "URL of the server under test"
  default     = ""
}
