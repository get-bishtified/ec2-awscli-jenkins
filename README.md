# 

# \# 🚀 Jenkins EC2 Provisioning using AWS CLI (IAM Role)

# 

# This repository demonstrates how to \*\*provision an Amazon EC2 instance using Jenkins and AWS CLI\*\*, without using Terraform or CloudFormation.

# 

# The setup follows \*\*AWS best practices\*\* by using an \*\*IAM Role attached to the Jenkins EC2 instance\*\*, eliminating the need for hardcoded AWS credentials.

# 

# ---

# 

# \## 🧠 High-Level Workflow

# 

# ```

# Git Repository

# &nbsp;    ↓

# Jenkins Pipeline

# &nbsp;    ↓

# AWS CLI (IAM Role Authentication)

# &nbsp;    ↓

# Amazon EC2 Instance

# ```

# 

# ---

# 

# \## 📁 Repository Structure

# 

# ```

# .

# ├── Jenkinsfile

# ├── scripts/

# │   └── create-ec2.sh

# └── README.md

# ```

# 

# ---

# 

# \## 🔐 Prerequisites

# 

# \### Jenkins EC2 IAM Role (Required)

# 

# Attach an IAM role to the Jenkins EC2 instance with the following permissions:

# 

# ```json

# {

# &nbsp; "Version": "2012-10-17",

# &nbsp; "Statement": \[

# &nbsp;   {

# &nbsp;     "Effect": "Allow",

# &nbsp;     "Action": \[

# &nbsp;       "ec2:RunInstances",

# &nbsp;       "ec2:DescribeInstances",

# &nbsp;       "ec2:CreateTags",

# &nbsp;       "ec2:DescribeSubnets",

# &nbsp;       "ec2:DescribeSecurityGroups",

# &nbsp;       "ec2:DescribeImages"

# &nbsp;     ],

# &nbsp;     "Resource": "\*"

# &nbsp;   }

# &nbsp; ]

# }

# ```

# 

# Verify IAM role access:

# ```bash

# aws sts get-caller-identity

# ```

# 

# ---

# 

# \## 📜 Jenkins Pipeline

# 

# ```groovy

# pipeline {

# &nbsp; agent any

# 

# &nbsp; stages {

# &nbsp;   stage('Checkout') {

# &nbsp;     steps {

# &nbsp;       checkout scm

# &nbsp;     }

# &nbsp;   }

# 

# &nbsp;   stage('Verify AWS Access') {

# &nbsp;     steps {

# &nbsp;       sh 'aws sts get-caller-identity'

# &nbsp;     }

# &nbsp;   }

# 

# &nbsp;   stage('Provision EC2') {

# &nbsp;     steps {

# &nbsp;       sh '''

# &nbsp;         chmod +x scripts/create-ec2.sh

# &nbsp;         ./scripts/create-ec2.sh

# &nbsp;       '''

# &nbsp;     }

# &nbsp;   }

# &nbsp; }

# }

# ```

# 

# ---

# 

# \## 🧾 EC2 Provisioning Script

# 

# ```bash

# \#!/bin/bash

# set -e

# 

# REGION="ap-south-1"

# AMI\_ID="ami-xxxxxxxx"

# INSTANCE\_TYPE="t3.micro"

# KEY\_NAME="my-keypair"

# SUBNET\_ID="subnet-xxxx"

# SECURITY\_GROUP\_ID="sg-xxxx"

# 

# aws ec2 run-instances \\

# &nbsp; --region $REGION \\

# &nbsp; --image-id $AMI\_ID \\

# &nbsp; --instance-type $INSTANCE\_TYPE \\

# &nbsp; --count 1 \\

# &nbsp; --key-name $KEY\_NAME \\

# &nbsp; --subnet-id $SUBNET\_ID \\

# &nbsp; --security-group-ids $SECURITY\_GROUP\_ID \\

# &nbsp; --tag-specifications 'ResourceType=instance,Tags=\[{Key=Name,Value=jenkins-awscli-ec2}]'

# ```

# 

# ---

# 

# \## ▶️ How to Run

# 

# 1\. Push this repository to GitHub

# 2\. Create a Jenkins Pipeline job

# 3\. Select \*\*Pipeline from SCM\*\*

# 4\. Run the pipeline

# 

# ---

# 

# \## 🏁 Summary

# 

# A simple, secure, IAM-role-based Jenkins pipeline to provision EC2 using AWS CLI.



