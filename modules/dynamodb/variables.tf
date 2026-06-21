variable "table_name" {
  type        = string
  description = "DynamoDB table name"
}

variable "hash_key" {
  type        = string
  description = "Partition key"
  default     = "customerId"
}

variable "range_key" {
  type        = string
  description = "Sort key"
  default     = "itemId"
}

variable "tags" {
  type    = map(string)
  default = {}
}