output "endpoint" {
  value = aws_db_instance.this.endpoint
}

output "database_name" {
  value = aws_db_instance.this.db_name
}

output "secret_arn" {
  value = aws_db_instance.this.master_user_secret[0].secret_arn
}
output "master_user_secret_arn" {
  value = aws_db_instance.this.master_user_secret[0].secret_arn
}