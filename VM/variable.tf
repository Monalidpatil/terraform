variable "project_id" {
  description = "The GCP Project ID."
  type        = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}
variable "instance_count" {
  type    = number
  default = 1
}

variable "machine_type" {
  type = string
}

variable "vpc_link" {
  type = string
}

variable "subnet_link" {
  type = string
}