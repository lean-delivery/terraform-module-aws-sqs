output "id" {
  description = "The URL for the created Amazon SQS queue"
  value       = "${var.count == 0 ? "" : element(concat(aws_sqs_queue.queue.*.id, list("")), "0")}"
}

output "arn" {
  description = "The ARN of the SQS queue"
  value       = "${var.count == 0 ? "" : element(concat(aws_sqs_queue.queue.*.arn, list("")), "0")}"
}
