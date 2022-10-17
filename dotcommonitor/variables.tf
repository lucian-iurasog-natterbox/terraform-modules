variable "url_to_test" {
  description = "The url of the request of the task"
  type        = string
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "deploy_filter" {
  type        = set(string)
  default     = []
  description = "Enable filter"
}

variable "task_name" {
  type        = string
  description = "The name of the Dotcom task"
  default     = "Task"
}

variable "locations" {
  type        = set(number)
  description = "The list of location ID's for monitoring agents"
  default     = [2, 3, 4]
}

variable "platform_id" {
  type        = number
  description = "The ID of the platform of the device"
  default     = 1
}

variable "frequency" {
  type        = number
  description = "The frequency that that the device checks at, in seconds"
  default     = 60
}

variable "task_type_id" {
  type        = number
  description = "The ID of the task type to use for the task"
  default     = 2
}

variable "ssl_expiration_reminder_in_days" {
  type        = number
  description = "Sends an expiration alert X number of days prior to certificate expiration"
  default     = 0
}
variable "filter_name" {
  type        = string
  description = "The name of the filter"
  default     = "Filter"
}

variable "filter_num_locations" {
  type        = number
  description = "The number of monitoring locations which are sending error responses. Must be at least 1"
  default     = 1
}

variable "filter_num_tasks" {
  type        = number
  description = "The number of failed taks. Must be at least 1"
  default     = 1
}

variable "owner_device_down" {
  type        = bool
  description = "Indicates if verification is enabled for if an owner device is down. Defaults to false."
  default     = false
}

variable "filter_type" {
  type        = string
  description = "The ignored error type"
  default     = "http"
}

variable "filter_code" {
  type        = string
  description = "The ignored error codes. Support single error codes and ranges of error codes"
  default     = "404"
}
variable "device_name" {
  type        = string
  description = "The name of the Dotcom device"
  default     = "Device"
}

variable "request_type" {
  type        = string
  description = "The type of request of the task. Can be one of GET, POST, HEAD, PUT, DELETE, OPTIONS, TRACE, PATCH"
  default     = "GET"
}

variable "time_shift_min" {
  type        = string
  description = "The escalation time for the alert, in minutes. Can be one of 0-180, increments of 10"
  default     = 10
}
variable "notifications_groups" {
  type = map(map(object({ name = string })))
}

variable "send_uptime_alert" {
  type        = bool
  description = "Indicates if uptime alerts should be sent when a device begins successfully completing tasks after a failure"
  default     = false
}

variable "false_positive_check" {
  type        = bool
  description = "Indicates if the device should check for false positives (brief hiccup / network glitch)"
  default     = false
}

variable "check_ssl_certificate_date" {
  type        = bool
  description = "Indicates if the task should check the SSL certificate date"
  default     = false
}

variable "check_ssl_certificate_authority" {
  type        = bool
  description = "Indicates if the task should check the SSL certificate authority"
  default     = false
}

variable "check_ssl_certificate_cn" {
  type        = bool
  description = "Indicates if the task should check the SSL certificate CN"
  default     = false
}

variable "dns_server_ip" {
  type        = string
  description = "The IP of a DNS server to use for the task"
  default     = "8.8.8.8"
}
