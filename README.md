##############################  Terraform Settings, Providers & Resource Blocks  ###########################################

#### Step-01: Introduction

    Terraform Settings
    Terraform Providers
    Terraform Resources
    Terraform File Function
    Create EC2 Instance using Terraform and provision a webserver with userdata.

#### Step-02: In c1-versions.tf - Create Terraform Settings Block

    Understand about Terraform Settings Block and create it

terraform {
  required_version = "~> 0.14" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#### Step-03: In c1-versions.tf - Create Terraform Providers Block

    Understand about Terraform Providers
    Configure AWS Credentials in the AWS CLI if not configured

##  Verify AWS Credentials
cat $HOME/.aws/credentials

    Create AWS Providers Block

##  Provider Block
provider "aws" {
  region  = us-east-1
  profile = "default"
}

#### Step-04: In c2-ec2instance.tf - Create Resource Block

    Understand about Resources
    Create EC2 Instance Resource
    Understand about File Function
    Understand about Resources - Argument Reference
    Understand about Resources - Attribute Reference

#### Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = "ami-0533f2ba8a1995cf9"
  instance_type = "t3.micro"
  user_data = file("${path.module}/bash-script.sh")
  tags = {
    "Name" = "EC2Demo"
  }
}

Step-05: Review file bash-script.sh

#! /bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2  

#### Step-06: Execute Terraform Commands

## Terraform Initialize

terraform init

Observation:
1) Initialized Local Backend
2) Downloaded the provider plugins (initialized plugins)
3) Review the folder structure ".terraform folder"

## Terraform Validate

terraform validate

Observation:
1) If any changes to files, those will come as printed in stdout (those file names will be printed in CLI)

## Terraform Plan

terraform plan

Observation:
1) No changes - Just prints the execution plan

## Terraform Apply

terraform apply 

[or]

terraform apply -auto-approve

Observations:
1) Create resources on cloud
2) Created terraform.tfstate file when you run the terraform apply command

#### Step-07: Access Application

    Important Note: verify if default VPC security group has a rule to allow port 80

# Access apache2 is running.
http://<PUBLIC-IP>

#### Step-08: Terraform State - Basics

    Understand about Terraform State
    Terraform State file terraform.tfstate
    Understand about Desired State and Current State

#### Step-09: Clean-Up

## Terraform Destroy

terraform plan -destroy  # You can view destroy plan using this command

terraform destroy

#### Clean-Up Files

sudo rm -rf .terraform*

sudo rm -rf terraform.tfstate*


 ################################################ END ############################################
