package test

import (
	"testing"
	// "fmt"
	"time"
    "math/rand"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

var terraformDirectory = "../examples"
var region             = "us-east-1"
var account            = ""

func Test_SetUp(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: terraformDirectory,
		Vars: map[string]interface{}{
			"aws_region": region,
		},
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.Init(t, terraformOptions)
	terraform.Apply(t, terraformOptions)
	account = terraform.Output(t, terraformOptions, "account_id")
}

func TestSQS_without_deadletter(t *testing.T) {
	rand.Seed(time.Now().UnixNano())

	name_without_deadletter   := randSeq(10) + "_without_deadletter"
	config_without_deadletter :=map[string]interface{}{
		"aws_region": region,
		"name": name_without_deadletter,
	}
	TerraformSQS(t,
		name_without_deadletter,
		config_without_deadletter,
		"https://sqs." + region + ".amazonaws.com/" + account + "/" + name_without_deadletter,
		"arn:aws:sqs:" + region + ":" + account + ":" + name_without_deadletter,
		"",
		"")
}


func TestSQS_with_deadletter(t *testing.T) {
	rand.Seed(time.Now().UnixNano())

	name_with_deadletter   := randSeq(10) + "_with_deadletter"
	config_with_deadletter :=  map[string]interface{}{
		"redrive_policy_count": 4,
		"aws_region": region,
		"name": name_with_deadletter,
	}
	TerraformSQS(t,
		name_with_deadletter,
		config_with_deadletter,
		"https://sqs." + region + ".amazonaws.com/" + account + "/" + name_with_deadletter,
		"arn:aws:sqs:" + region + ":" + account + ":" + name_with_deadletter,
		"https://sqs." + region + ".amazonaws.com/" + account + "/deadletter_" + name_with_deadletter,
		"arn:aws:sqs:" + region + ":" + account + ":deadletter_" + name_with_deadletter)
}

func TestSQS_fifo(t *testing.T) {
	rand.Seed(time.Now().UnixNano())

	name_fifo   := randSeq(10) + "_fifo"
	config_fifo := map[string]interface{}{
		"aws_region": region,
		"fifo_queue": "true",
		"name": name_fifo,
	}
	TerraformSQS(t,
		name_fifo,
		config_fifo,
		"https://sqs." + region + ".amazonaws.com/" + account + "/" + name_fifo + ".fifo",
		"arn:aws:sqs:" + region + ":" + account + ":" + name_fifo + ".fifo",
		"",
		"")
}

func randSeq(n int) string {
	letters := []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    b := make([]rune, n)
    for i := range b {
        b[i] = letters[rand.Intn(len(letters))]
    }
    return string(b)
}

func TerraformSQS(t *testing.T, name string, config map[string]interface{}, expected_queue_id string, expected_queue_arn string, expected_queue_deadletter_id string, expected_queue_deadletter_arn string) {
	terraformOptions := &terraform.Options{
		TerraformDir: terraformDirectory,
		Vars: config,
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.Init(t, terraformOptions)
	terraform.Apply(t, terraformOptions)

	queue_id   			 := terraform.Output(t, terraformOptions, "queue_id")
	queue_arn  			 := terraform.Output(t, terraformOptions, "queue_arn")
	queue_deadletter_id  := terraform.Output(t, terraformOptions, "queue_deadletter_id")
	queue_deadletter_arn := terraform.Output(t, terraformOptions, "queue_deadletter_arn")

	assert.Equal(t, expected_queue_id,             queue_id)
	assert.Equal(t, expected_queue_arn,            queue_arn)
	assert.Equal(t, expected_queue_deadletter_id,  queue_deadletter_id)
	assert.Equal(t, expected_queue_deadletter_arn, queue_deadletter_arn)
}
