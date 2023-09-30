variable "project" {
  type        = string
  description = "(Required) Application project name."
}

variable "environment" {
  type        = string
  description = "(Optional) Application environment for deployment, defaults to development."
  default     = "development"
}

variable "region" {
  type        = string
  description = "(Optional) The region where the resources are created. Defaults to us-east-1."
  default     = "us-east-1"
}

variable "vpc_id" {
  type        = string
  description = "(Required) The region where the resources are created. Defaults to us-east-1."
  default     = "vpc-00a915c5d2c6d0c4c"
}

