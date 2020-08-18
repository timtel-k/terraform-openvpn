variable "ssh_key" {}
variable "ssh_key_name" {}
variable "host_name" {}
variable "host_route_53_zone_id" {}
variable "region" {}

variable "vpn_admin_login" {
  type        = string
  default     = "openvpn"
}

variable "vpn_admin_password" {
  type        = string
  default     = "openvpn"
}

variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = ""
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "The VPC ID to launch in"
  type        = string
  default     = ""
}


variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = ""
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = true
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}



