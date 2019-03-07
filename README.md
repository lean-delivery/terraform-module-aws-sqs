## Description

Module for creating Simple Queue Service.
Includes 3 submodules for creating SQS with/without/with_own deadletter (Not realizable otherwise in version 0.11)

## Usage

```hcl
module "sqs1" {
  source     = "tf-module-aws-sqs/"
  name       = "My_SQS_with_deadletter"
  fifo_queue = "true"
  redrive_policy_count = 4
}

module "sqs2" {
  source     = "tf-module-aws-sqs/"
  name       = "My_SQS_with_own_deadletter"
  redrive_policy_count = 1
  redrive_policy_arn   = "arn:aws:sqs:eu-west-1:800457684105:deadletter_sqs"
}

module "sqs3" {
  source     = "tf-module-aws-sqs/"
  name       = "My_SQS_without_deadletter"
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | Project name will be used for naming resources in pattern %PROJECT_NAME%-%ENVIRONMENT_NAME% | | "project" | no |
| environment | Environment name will be used for naming resources in pattern %PROJECT_NAME%-%ENVIRONMENT_NAME% | | "test" | no |
| name | This is the human-readable name of the queue. If omitted, module will assign %PROJECT_NAME%-%ENVIRONMENT_NAME% | "string" | "" | no |
| tags | A mapping of tags to assign to the queue. | "map" | {} | no |
| visibility_timeout_seconds | The visibility timeout for the queue. An integer from 0 to 43200 | | 30 | no |
| message_retention_seconds | The number of seconds Amazon SQS retains a message. Integer representing seconds from 60 to 1209600 | | 345600 | no |
| max_message_size | The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes up to 262144 bytes | | 262144 | no |
| delay_seconds | The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 | | 0 | no |
| receive_wait_time_seconds | The time for which a ReceiveMessage call will wait for a message to arrive before returning. An integer from 0 to 20 seconds | | 0 | no |
| redrive_policy_count | COUNT FOR The JSON policy to set up the Dead Letter Queue see AWS docs. Note - when specifying maxReceiveCount you must specify it as an integer and not a string | | 0 | no |
| redrive_policy_arn | ARN FOR The JSON policy to set up the Dead Letter Queue | "string" | "" | no |
| fifo_queue | Designating a FIFO queue. If not set it defaults to false making it standard | "string" | "false" | no |
| content_based_deduplication | Enables content-based deduplication for FIFO queues | "string" | "" | no |
| kms_master_key_id | The ID of an AWS-managed customer master key for Amazon SQS or a custom CMK | "string" | "" | no |
| kms_data_key_reuse_period_seconds | The length of time in seconds for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds between 60 seconds and 86400 seconds | | 300 | no |


## Outputs

| Name | Description |
|------|-------------|
| queue_id | The URL for the created Amazon SQS queue |
| queue_arn | The ARN of the SQS queue |
| queue_deadletter_id | The URL for the created Amazon queue_deadletter |
| queue_deadletter_arn | The ARN of the queue_deadletter |

## Terraform versions

Terraform version 0.11.11 or newer is required for this module to work.

## Contributing

Thank you for your interest in contributing! Please refer to [CONTRIBUTING.md](https://github.com/lean-delivery/tf-module-aws-sqs/blob/master/CONTRIBUTING.md) for guidance.

## License

Apache2.0 Licensed. See [LICENSE](https://github.com/lean-delivery/tf-module-aws-sqs/tree/master/LICENSE) for full details.

## Authors

Lean Delivery Team <team@lean-delivery.com>
