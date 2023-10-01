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

variable "user_data" {
  type = string
  description = "(Required) user data to load "
  default = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Taco Team Server 2</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a double &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF  
}

