output "queue_id" {
  value       = "${module.sqs.queue_id}"
  description = "The URL for the created Amazon SQS queue"
}

output "queue_arn" {
  value       = "${module.sqs.queue_arn}"
  description = "The ARN of the SQS queue"
}

output "queue_deadletter_id" {
  value       = "${module.sqs.queue_deadletter_id}"
  description = "The URL for the created Amazon queue_deadletter"
}

output "queue_deadletter_arn" {
  value       = "${module.sqs.queue_deadletter_arn}"
  description = "The ARN of the queue_deadletter"
}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "caller_arn" {
  value = "${data.aws_caller_identity.current.arn}"
}

output "caller_user" {
  value = "${data.aws_caller_identity.current.user_id}"
}
