variable "region" {
  description = "Set aws region"
}

variable "aws_profile" {
  description = "Set the aws cli profile to use"
}

variable "volume_type" {
  description = "The type of volume, gp2 or io1 or sc1st1"
}

variable "volume_size" {
  description = "size of the ebs volume needed"
}

variable "key_name" {}
variable "vm_name" {}
variable "instance_type" {}

variable "az1a" {}
variable "az1b" {}
variable "az1c" {}
variable "az1d" {}

variable "psubnet_id1c" {}
variable "psubnet_id1d" {}

variable "subnet_id1d" {}
variable "cert_domain" {}
variable "site_name" {}
variable "vpc_id" {}
variable "sg_id" {}
