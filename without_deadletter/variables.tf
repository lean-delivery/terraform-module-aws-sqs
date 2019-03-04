variable "project" {
  description = "Project name will be used for naming resources in pattern %PROJECT_NAME%-%ENVIRONMENT_NAME%"
  default     = "project"
}

variable "environment" {
  description = "Environment name will be used for naming resources in pattern %PROJECT_NAME%-%ENVIRONMENT_NAME%"
  default     = "test"
}

variable "name" {
  type        = "string"
  description = "QWERTYU"
  default     = ""
}

variable "tags" {
  type        = "map"
  description = "A mapping of tags to assign to the queue."
  default     = {}
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue. An integer from 0 to 43200"
  default     = 30
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds from 60 to 1209600"
  default     = 345600
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes up to 262144 bytes"
  default     = 262144
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900"
  default     = 0
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive before returning. An integer from 0 to 20 seconds"
  default     = 0
}

variable "fifo_queue" {
  type        = "string"
  description = "Designating a FIFO queue. If not set it defaults to false making it standard."
  default     = "false"
}

variable "content_based_deduplication" {
  type        = "string"
  description = "Enables content-based deduplication for FIFO queues"
  default     = ""
}

variable "kms_master_key_id" {
  type        = "string"
  description = "The ID of an AWS-managed customer master key for Amazon SQS or a custom CMK"
  default     = ""
}

variable "kms_data_key_reuse_period_seconds" {
  description = "The length of time in seconds for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds between 60 seconds and 86400 seconds"
  default     = 300
}

variable "count" {
  default = 1
}
