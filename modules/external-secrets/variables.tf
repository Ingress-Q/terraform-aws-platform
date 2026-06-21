variable "name" { type = string }
variable "project" { type = string }
variable "environment" { type = string }
variable "cluster_name" { type = string }
variable "region" { type = string }
variable "tags" {
  type    = map(string)
  default = {}
}
variable "secret_arns" {
  type = list(string)
}