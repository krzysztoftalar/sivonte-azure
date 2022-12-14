variable "owner" {
  description = "(Required) Company to which the projects belong."
  type        = string
}

variable "project" {
  description = "(Required) The name of the project."
  type        = string
}

variable "environment" {
  description = "(Required) The name of the environment."
  type        = string
}

variable "management" {
  description = "(Required) A description of how this resource is managed, such as `Terraform Cloud - Local`, `Terraform Cloud - Remote`."
  type        = string
}
