module "sqs1" {
  source               = "tf-module-aws-sqs/"
  name                 = "My_SQS_with_deadletter"
  fifo_queue           = "true"
  redrive_policy_count = 4
}

module "sqs2" {
  source               = "tf-module-aws-sqs/"
  name                 = "My_SQS_with_own_deadletter"
  redrive_policy_count = 1
  redrive_policy_arn   = "arn:aws:sqs:eu-west-1:800457684105:deadletter_sqs"
}

module "sqs3" {
  source = "tf-module-aws-sqs/"
  name   = "My_SQS_without_deadletter"
}
