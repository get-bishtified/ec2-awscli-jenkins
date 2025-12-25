#!/bin/bash
set -e
REGION="ap-south-1"
AMI_ID="ami-00ca570c1b6d79f36"
INSTANCE_TYPE="t3.micro"
KEY_NAME="shankaz"
SUBNET_ID="subnet-0be71324797f065dd"
SECURITY_GROUP_ID="sg-086d498926b570b8c"

aws ec2 run-instances   --region $REGION   --image-id $AMI_ID   --instance-type $INSTANCE_TYPE   --count 1   --key-name $KEY_NAME   --subnet-id $SUBNET_ID   --security-group-ids $SECURITY_GROUP_ID   --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=jenkins-awscli-ec2}]'
