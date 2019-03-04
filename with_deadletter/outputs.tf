output "id" {
  value       = "${var.count == 0 ? "" : element(concat(aws_sqs_queue.queue.*.id, list("")), "0")}"
  description = "The URL for the created Amazon SQS queue"
}

output "arn" {
  value       = "${var.count == 0 ? "" : element(concat(aws_sqs_queue.queue.*.arn, list("")), "0")}"
  description = "The ARN of the SQS queue"
}

output "queue_deadletter_id" {
  value       = "${var.count == 0 ? "" : element(concat(aws_sqs_queue.queue_deadletter.*.id, list("")), "0")}"
  description = "The URL for the created Amazon queue_deadletter"
}

output "queue_deadletter_arn" {
  value       = "${var.count == 0 ? "" : element(concat(aws_sqs_queue.queue_deadletter.*.arn, list("")), "0")}"
  description = "The ARN of the queue_deadletter"
}
