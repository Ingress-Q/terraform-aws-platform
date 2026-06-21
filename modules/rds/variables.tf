variable "identifier" {
  type = string
}

variable "db_name" {
  type = string
}

variable "master_username" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "port" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "allowed_security_group_ids" {
  type = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}