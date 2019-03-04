output "queue_id" {
  value       = "${local.id}"
  description = "The URL for the created Amazon SQS queue"
}

output "queue_arn" {
  value       = "${local.arn}"
  description = "The ARN of the SQS queue"
}

output "queue_deadletter_id" {
  value       = "${local.deadletter_id}"
  description = "The URL for the created Amazon queue_deadletter"
}

output "queue_deadletter_arn" {
  value       = "${local.deadletter_arn}"
  description = "The ARN of the queue_deadletter"
}
