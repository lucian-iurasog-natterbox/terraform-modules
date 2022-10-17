variable "env" {
  type        = string
  description = "Environment Selector."
  validation {
    condition     = contains(["dev01", "dev02", "dev03", "dev04", "dev05", "qa01", "qa02", "stg", "prod", "local"], var.env)
    error_message = "Valid values for var: env are (dev01,dev02,dev03,dev04,dev05,qa01,qa02,stg,prod,local)."
  }
}
#########################
# CONTAINER ENV  ########
#########################
variable "ENVIRONMENT_VARIABLES" {
  type        = any
  description = "Application Environment variables map."
}

#########################
# END CONTAINER ENV END ####
#########################

#########################
# Deploy Setup  ########
#########################
variable "name" {
  description = "Deployment App Name"
  type        = string
}
variable "pod_image" {
  description = "Container Image"
  type        = string
}

variable "number_of_replicas" {
  default     = 1
  description = "Number of pod replicas set in the app deployment, default is set to 1."
  type        = number
}

# variable "max_number_of_replicas" {
#   default     = 10
#   description = "Max number of pod replicas set in the app deployment, default is set to 10, for autoscalling."
#   type        = number
# }
variable "local_ingress_identifier" {
  type        = string
  description = "Minikube ingress app identifier, should be added in case of you want to deploy multiple different apps on the same minikube, also add this value to your local hosts file."
  default     = ""
}
variable "dns_zone" {
  default     = ""
  description = "Host to be set on the ingress rule."
}
variable "healthcheck_uri" {
  type        = string
  description = "ALB healthcheck uri."
  default     = ""
}
variable "exposed_ports" {
  type = map(object(
    {
      container_listening_port          = number
      container_listening_port_protocol = string
    }
  ))
  description = "Map of exposed ports."
  default = {
    80 = {
      container_listening_port          = 80
      container_listening_port_protocol = "TCP"
    }
    443 = {
      container_listening_port          = 80
      container_listening_port_protocol = "TCP"
    }
  }
}
