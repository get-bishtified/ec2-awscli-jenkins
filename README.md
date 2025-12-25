###### 

###### \# 🚀 Jenkins EC2 Provisioning using AWS CLI (IAM Role)

###### 

###### This repository demonstrates how to \*\*provision an Amazon EC2 instance using Jenkins and AWS CLI\*\*, without using Terraform or CloudFormation.

###### 

###### The setup follows \*\*AWS best practices\*\* by using an \*\*IAM Role attached to the Jenkins EC2 instance\*\*, eliminating the need for hardcoded AWS credentials.

###### 

###### ---

###### 

###### \## 🧠 High-Level Workflow

###### 

###### ```

###### Git Repository

######      ↓

###### Jenkins Pipeline

######      ↓

###### AWS CLI (IAM Role Authentication)

######      ↓

###### Amazon EC2 Instance

###### ```

###### 

###### ---

###### 

###### \## 📁 Repository Structure

###### 

###### ```

###### .

###### ├── Jenkinsfile

###### ├── scripts/

###### │   └── create-ec2.sh

###### └── README.md

###### ```

###### 

###### ---

###### 

###### \## 🔐 Prerequisites

###### 

###### \### Jenkins EC2 IAM Role (Required)

###### 

###### Attach an IAM role to the Jenkins EC2 instance with the following permissions:

###### 

###### ```json

###### {

######   "Version": "2012-10-17",

######   "Statement": \[

######     {

######       "Effect": "Allow",

######       "Action": \[

######         "ec2:RunInstances",

######         "ec2:DescribeInstances",

######         "ec2:CreateTags",

######         "ec2:DescribeSubnets",

######         "ec2:DescribeSecurityGroups",

######         "ec2:DescribeImages"

######       ],

######       "Resource": "\*"

######     }

######   ]

###### }

###### ```

###### 

###### Verify IAM role access:

###### ```bash

###### aws sts get-caller-identity

###### ```

###### 

###### ---

###### 

###### \## 📜 Jenkins Pipeline

###### 

###### ```groovy

###### pipeline {

######   agent any

###### 

######   stages {

######     stage('Checkout') {

######       steps {

######         checkout scm

######       }

######     }

###### 

######     stage('Verify AWS Access') {

######       steps {

######         sh 'aws sts get-caller-identity'

######       }

######     }

###### 

######     stage('Provision EC2') {

######       steps {

######         sh '''

######           chmod +x scripts/create-ec2.sh

######           ./scripts/create-ec2.sh

######         '''

######       }

######     }

######   }

###### }

###### ```

###### 

###### ---

###### 

###### \## 🧾 EC2 Provisioning Script

###### 

###### ```bash

###### \#!/bin/bash

###### set -e

###### 

###### REGION="ap-south-1"

###### AMI\_ID="ami-xxxxxxxx"

###### INSTANCE\_TYPE="t3.micro"

###### KEY\_NAME="my-keypair"

###### SUBNET\_ID="subnet-xxxx"

###### SECURITY\_GROUP\_ID="sg-xxxx"

###### 

###### aws ec2 run-instances \\

######   --region $REGION \\

######   --image-id $AMI\_ID \\

######   --instance-type $INSTANCE\_TYPE \\

######   --count 1 \\

######   --key-name $KEY\_NAME \\

######   --subnet-id $SUBNET\_ID \\

######   --security-group-ids $SECURITY\_GROUP\_ID \\

######   --tag-specifications 'ResourceType=instance,Tags=\[{Key=Name,Value=jenkins-awscli-ec2}]'

###### ```

###### 

###### ---

###### 

###### \## ▶️ How to Run

###### 

###### 1\. Push this repository to GitHub

###### 2\. Create a Jenkins Pipeline job

###### 3\. Select \*\*Pipeline from SCM\*\*

###### 4\. Run the pipeline

###### 

###### ---

###### 

###### \## 🏁 Summary

###### 

###### A simple, secure, IAM-role-based Jenkins pipeline to provision EC2 using AWS CLI.

