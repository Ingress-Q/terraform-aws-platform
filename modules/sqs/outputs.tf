output "queue_name" {
  value = aws_sqs_queue.karpenter_interruption.name
}

output "queue_arn" {
  value = aws_sqs_queue.karpenter_interruption.arn
}