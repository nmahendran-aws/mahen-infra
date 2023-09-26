variable "project" {
  type        = string
  description = "(Required) Application project name."
}

variable "environment" {
  type        = string
  description = "(Optional) Application environment for deployment, defaults to development."
  default     = "development"
}
