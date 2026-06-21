variable "identifier" {
  type = string
}
variable "engine_version" {
  type    = string
  default = "7.1"
}
variable "node_type" {
  type    = string
  default = "cache.t3.micro"
}
variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "allowed_security_group_ids" {
  type = list(string)
}
variable "tags" {
  type    = map(string)
  default = {}
}