output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC"
}

output "public" {
  value       = aws_subnet.public.*.id
  description = "IDs of public subnets"
}

output "private" {
  value       = aws_subnet.private.*.id
  description = "IDs of private subnets"
}

output "private_db" {
  value       = aws_subnet.private_db.*.id
  description = "IDs of private DB subnets"
}
