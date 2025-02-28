#------------------------------------------------------------------------------
# written by: Lawrence McDaniel
#             https://lawrencemcdaniel.com/
#
# date: Mar-2022
#
# usage: create an EKS cluster
#------------------------------------------------------------------------------
variable "dashboard_namespace" {
  type = string
}

variable "dashboard_account_name" {
  type = string
}

variable "stack_namespace" {
  type = string
}

variable "services_subdomain" {
  type = string
}
variable "tags" {
  description = "A map of tags to add to all resources. Tags added to launch configuration or templates override these values for ASG Tags only."
  type        = map(string)
  default     = {}
}
