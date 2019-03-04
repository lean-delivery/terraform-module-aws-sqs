resource "aws_sqs_queue" "queue" {
  count                             = "${var.count}"
  name                              = "${var.name}"
  tags                              = "${var.tags}"
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
