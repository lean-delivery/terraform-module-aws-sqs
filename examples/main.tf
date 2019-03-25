provider "aws" {
  region = "${var.region}"
}

data "aws_caller_identity" "current" {}

module "sqs" {
  source                            = "../"
  project                           = "${var.project}"
  environment                       = "${var.environment}"
  name                              = "${var.name}"
  tags                              = "${var.tags}"
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
