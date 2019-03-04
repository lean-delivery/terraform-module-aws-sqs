locals {
  default_tags = {
    Name        = "${var.project}-${var.environment}"
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }

  id             = "${ var.redrive_policy_count == 0 ? module.queue_without_deadletter.without_deadletter_id  : "${var.redrive_policy_arn != "" ? module.queue_with_own_deadletter.with_own_deadletter_id  : module.queue_with_deadletter.with_deadletter_id }"}"
  arn            = "${ var.redrive_policy_count == 0 ? module.queue_without_deadletter.without_deadletter_arn : "${var.redrive_policy_arn != "" ? module.queue_with_own_deadletter.with_own_deadletter_arn : module.queue_with_deadletter.with_deadletter_arn }"}"
  deadletter_id  = "${ var.redrive_policy_count == 0 ? "" : module.queue_with_deadletter.created_deadletter_id  }"
  deadletter_arn = "${ var.redrive_policy_count == 0 ? "" : module.queue_with_deadletter.created_deadletter_arn }"
}

module "queue_without_deadletter" {
  count                             = "${ var.redrive_policy_count == 0 ? 1 : 0}"
  source                            = "without_deadletter/"
  name                              = "${ var.name == "" ? "${var.project}-${var.environment}" : var.name }${ var.fifo_queue == "true" ? ".fifo" : ""}"
  tags                              = "${local.default_tags}"
  visibility_timeout_seconds        = "${var.visibility_timeout_seconds}"
  message_retention_seconds         = "${var.message_retention_seconds}"
  max_message_size                  = "${var.max_message_size}"
  delay_seconds                     = "${var.delay_seconds}"
  receive_wait_time_seconds         = "${var.receive_wait_time_seconds}"
  fifo_queue                        = "${var.fifo_queue}"
  content_based_deduplication       = "${var.content_based_deduplication}"
  kms_master_key_id                 = "${var.kms_master_key_id}"
  kms_data_key_reuse_period_seconds = "${var.kms_data_key_reuse_period_seconds}"
}

module "queue_with_deadletter" {
  count                             = "${ var.redrive_policy_count != 0 && var.redrive_policy_arn == "" ? 1 : 0}"
  source                            = "with_deadletter/"
  name                              = "${ var.name == "" ? "${var.project}-${var.environment}" : var.name }${ var.fifo_queue == "true" ? ".fifo" : ""}"
  tags                              = "${local.default_tags}"
  visibility_timeout_seconds        = "${var.visibility_timeout_seconds}"
  message_retention_seconds         = "${var.message_retention_seconds}"
  max_message_size                  = "${var.max_message_size}"
  delay_seconds                     = "${var.delay_seconds}"
  receive_wait_time_seconds         = "${var.receive_wait_time_seconds}"
  redrive_policy_count              = "${var.redrive_policy_count}"
  fifo_queue                        = "${var.fifo_queue}"
  content_based_deduplication       = "${var.content_based_deduplication}"
  kms_master_key_id                 = "${var.kms_master_key_id}"
  kms_data_key_reuse_period_seconds = "${var.kms_data_key_reuse_period_seconds}"
}

module "queue_with_own_deadletter" {
  count                             = "${ var.redrive_policy_count != 0 && var.redrive_policy_arn != "" ? 1 : 0}"
  source                            = "with_own_deadletter/"
  name                              = "${ var.name == "" ? "${var.project}-${var.environment}" : var.name }${ var.fifo_queue == "true" ? ".fifo" : ""}"
  tags                              = "${local.default_tags}"
  visibility_timeout_seconds        = "${var.visibility_timeout_seconds}"
  message_retention_seconds         = "${var.message_retention_seconds}"
  max_message_size                  = "${var.max_message_size}"
  delay_seconds                     = "${var.delay_seconds}"
  receive_wait_time_seconds         = "${var.receive_wait_time_seconds}"
  redrive_policy_count              = "${var.redrive_policy_count}"
  redrive_policy_arn                = "${var.redrive_policy_arn}"
  fifo_queue                        = "${var.fifo_queue}"
  content_based_deduplication       = "${var.content_based_deduplication}"
  kms_master_key_id                 = "${var.kms_master_key_id}"
  kms_data_key_reuse_period_seconds = "${var.kms_data_key_reuse_period_seconds}"
}
