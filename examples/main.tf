module "sqs1" {
  source               = "../"
  name                 = "My_SQS_with_deadletter"
  fifo_queue           = "true"
  redrive_policy_count = 4
}

module "sqs2" {
  source               = "github.com/lean-delivery/tf-module-aws-sqs"
  name                 = "My_SQS_with_own_deadletter"
  redrive_policy_count = 1
}
