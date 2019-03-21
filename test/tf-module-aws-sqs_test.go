package test

import (
	"testing"
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

var terraformDirectory = "../examples"
var account            = "800457684105"
var region             = "us-east-1"


func TestTerraformSQS_with_deadletter(t *testing.T) {
	t.Parallel()

	name := "TEST_NAME_with_deadletter"

	expected_queue_id             := "https://sqs." + region + ".amazonaws.com/" + account + "/" + name
	expected_queue_deadletter_id  := "https://sqs." + region + ".amazonaws.com/" + account + "/deadletter_" + name
	expected_queue_arn            := "arn:aws:sqs:" + region + ":" + account + ":" + name
	expected_queue_deadletter_arn := "arn:aws:sqs:" + region + ":" + account + ":deadletter_" + name

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDirectory,

		Vars: map[string]interface{}{
			"redrive_policy_count": 4,
			"aws_region": region,
			"name": name,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.Init(t, terraformOptions)
	terraform.Apply(t, terraformOptions)

	queue_id   			 := terraform.Output(t, terraformOptions, "queue_id")
	queue_arn  			 := terraform.Output(t, terraformOptions, "queue_arn")
	queue_deadletter_id  := terraform.Output(t, terraformOptions, "queue_deadletter_id")
	queue_deadletter_arn := terraform.Output(t, terraformOptions, "queue_deadletter_arn")

	fmt.Println("======================================================")
	fmt.Println("queue_id "             + queue_id             + " / " + expected_queue_id)
	fmt.Println("queue_arn "            + queue_arn            + " / " + expected_queue_arn)
	fmt.Println("queue_deadletter_id "  + queue_deadletter_id  + " / " + expected_queue_deadletter_id)
	fmt.Println("queue_deadletter_arn " + queue_deadletter_arn + " / " + expected_queue_deadletter_arn)
	fmt.Println("======================================================")

	assert.Equal(t, expected_queue_id,             queue_id)
	assert.Equal(t, expected_queue_arn,            queue_arn)
	assert.Equal(t, expected_queue_deadletter_id,  queue_deadletter_id)
	assert.Equal(t, expected_queue_deadletter_arn, queue_deadletter_arn)
}

func TestTerraformSQS_without_deadletter(t *testing.T) {
	t.Parallel()

	name := "TEST_NAME_without_deadletter"

	expected_queue_id             := "https://sqs." + region + ".amazonaws.com/" + account + "/" + name
	expected_queue_arn            := "arn:aws:sqs:" + region + ":" + account + ":" + name
	expected_queue_deadletter_id  := ""
	expected_queue_deadletter_arn := ""


	terraformOptions := &terraform.Options{
		TerraformDir: terraformDirectory,

		Vars: map[string]interface{}{
			"aws_region": region,
			"name": name,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.Init(t, terraformOptions)
	terraform.Apply(t, terraformOptions)

	queue_id   			 := terraform.Output(t, terraformOptions, "queue_id")
	queue_arn  			 := terraform.Output(t, terraformOptions, "queue_arn")
	queue_deadletter_id  := terraform.Output(t, terraformOptions, "queue_deadletter_id")
	queue_deadletter_arn := terraform.Output(t, terraformOptions, "queue_deadletter_arn")

	fmt.Println("======================================================")
	fmt.Println("queue_id "             + queue_id             + " / " + expected_queue_id)
	fmt.Println("queue_arn "            + queue_arn            + " / " + expected_queue_arn)
	fmt.Println("queue_deadletter_id "  + queue_deadletter_id  + " / " + expected_queue_deadletter_id)
	fmt.Println("queue_deadletter_arn " + queue_deadletter_arn + " / " + expected_queue_deadletter_arn)
	fmt.Println("======================================================")

	assert.Equal(t, expected_queue_id,             queue_id)
	assert.Equal(t, expected_queue_arn,            queue_arn)
	assert.Equal(t, expected_queue_deadletter_id,  queue_deadletter_id)
	assert.Equal(t, expected_queue_deadletter_arn, queue_deadletter_arn)
}
