# Multi-Region Infrastructure Deployment with Terraform

This Terraform project is designed to deploy a multi-region infrastructure on AWS, facilitating the hosting of a WordPress application across multiple regions. The infrastructure includes Virtual Private Cloud (VPC), Security Groups, EC2 Instance, S3 Bucket, MySQL RDS, WordPress Service, and Application Load Balancer (ALB).

## Overview

The infrastructure architecture is meticulously crafted to support deployment in multiple AWS regions. Each component is modularized to ensure code reusability and maintainability of the Terraform codebase.

## Modules

### 1. Virtual Private Cloud (VPC)

- **Files:**
  - `modules/vpc/main.tf`: Defines the VPC resource.
  - `modules/vpc/variables.tf`: Contains input variables for the VPC module.
  - `modules/vpc/outputs.tf`: Defines output values for the VPC module.

### 2. Security Groups

- **Files:**
  - `modules/security_groups/main.tf`: Configures security groups for EC2 instances and RDS.
  - `modules/security_groups/variables.tf`: Contains input variables for the security groups module.
  - `modules/security_groups/outputs.tf`: Defines output values for the security groups module.

### 3. EC2 Instance

- **Files:**
  - `modules/ec2_instance/main.tf`: Launches an EC2 instance to host WordPress.
  - `modules/ec2_instance/variables.tf`: Contains input variables for the EC2 instance module.
  - `modules/ec2_instance/outputs.tf`: Defines output values for the EC2 instance module.

### 4. S3 Bucket

- **Files:**
  - `modules/s3_bucket/main.tf`: Creates an S3 bucket to store static assets for WordPress.
  - `modules/s3_bucket/variables.tf`: Contains input variables for the S3 bucket module.
  - `modules/s3_bucket/outputs.tf`: Defines output values for the S3 bucket module.

### 5. MySQL RDS

- **Files:**
  - `modules/rds/main.tf`: Sets up a MySQL RDS instance for the WordPress database.
  - `modules/rds/variables.tf`: Contains input variables for the RDS module.
  - `modules/rds/outputs.tf`: Defines output values for the RDS module.

### 6. WordPress Service

- **Files:**
  - `modules/wordpress_service/main.tf`: Orchestrates the deployment of WordPress on an EC2 instance within the VPC.
  - `modules/wordpress_service/variables.tf`: Contains input variables for the WordPress service module.
  - `modules/wordpress_service/outputs.tf`: Defines output values for the WordPress service module.

### 7. Application Load Balancer (ALB)

- **Files:**
  - `modules/alb/main.tf`: Configures an Application Load Balancer to distribute traffic to the WordPress service.
  - `modules/alb/variables.tf`: Contains input variables for the ALB module.
  - `modules/alb/outputs.tf`: Defines output values for the ALB module.

## Communication between Modules

- The VPC module provides the VPC ID, which is consumed by other modules requiring VPC integration.
- Security groups are applied to both EC2 instances and RDS instances to control inbound and outbound traffic.
- The EC2 instance module retrieves the subnet ID from the VPC module to ensure placement within the designated subnet.
- The S3 bucket module creates a bucket for storing static assets, which can be utilized by the WordPress service.
- The RDS module establishes the database infrastructure, with the endpoint accessible to the WordPress service.
- The WordPress service module coordinates the deployment of WordPress on an EC2 instance within the VPC, utilizing resources from other modules.
- The ALB module configures an Application Load Balancer to route traffic to the WordPress service, ensuring high availability and scalability.

## Terraform Variables

### `terraform.tfvars` File

The `terraform.tfvars` file contains input variables used by the Terraform configuration. Below are the variables that may need to be customized:

- **region**: The desired AWS region for deployment.
- **subnet_id**: The ID of the subnet where the infrastructure resources will be launched.
- **key_name**: The name of the SSH key pair used for accessing EC2 instances.

Example `terraform.tfvars` file:


region      = "us-east-1"     # Replace with your desired region
subnet_id   = "subnet-12345678"   # Replace with your subnet ID
key_name    = "my-keypair"     # Replace with your key pair name


## Architecture Diagram

A diagram showcasing the multi-region infrastructure deployment architecture is provided below:

```
+-------------------------------------------------------------+
|                    Multi-Region Infrastructure              |
+-------------------------------------------------------------+
|                                                             |
|        +------------------------+       +-----------------+ |
|        |        Region 1        |       |     Region 2    | |
|        +------------------------+       +-----------------+ |
|               |                            |                |
|        +----------------+         +----------------+        |
|        |      VPC       |         |      VPC       |        |
|        +----------------+         +----------------+        |
|               |                            |                |
|        +----------------+         +----------------+        |
|        |  Security      |         |  Security      |        |
|        |  Groups        |         |  Groups        |        |
|        +----------------+         +----------------+        |
|               |                            |                |
|        +----------------+         +----------------+        |
|        |   EC2          |         |   EC2          |        |
|        |   Instance     |         |   Instance     |        |
|        +----------------+         +----------------+        |
|               |                            |                |
|        +----------------+         +----------------+        |
|        |   S3           |         |   S3           |        |
|        |   Bucket       |         |   Bucket       |        |
|        +----------------+         +----------------+        |
|               |                            |                |
|        +----------------+         +----------------+        |
|        |   MySQL RDS    |         |   MySQL RDS    |        |
|        +----------------+         +----------------+        |
|               |                            |                |
|        +----------------+         +----------------+        |
|        | WordPress      |         | WordPress      |        |
|        | Service        |         | Service        |        |
|        +----------------+         +----------------+        |
|               |                            |                |
|        +----------------+         +----------------+        |
|        | Application    |         | Application    |        |
|        | Load Balancer  |         | Load Balancer  |        |
|        +----------------+         +----------------+        |
|                                                             |
+-------------------------------------------------------------+
```

This architecture diagram illustrates the interconnectedness of the various components across multiple regions, showcasing the resilience and scalability of the deployed infrastructure.

# Terraform AWS Access Setup Guide

This document provides a step-by-step guide to set up Terraform with AWS access, enabling it to manage AWS resources.

## Prerequisites

Before proceeding, ensure you have the following:

- An AWS account with appropriate permissions to create and manage resources.
- Terraform installed on your local machine. You can download it from the [official Terraform website](https://www.terraform.io/downloads.html).
- AWS CLI installed (optional but recommended). You can download it from the [AWS Command Line Interface website](https://aws.amazon.com/cli/).

## Steps to Setup AWS Access for Terraform

### 1. Create an IAM User

1. Log in to the AWS Management Console.
2. Go to the IAM service.
3. Click on "Users" in the left navigation pane.
4. Click on "Add user".
5. Enter a username for the IAM user (e.g., "terraform").
6. Select "Programmatic access" as the access type.
7. Click on "Next: Permissions".
8. Attach the necessary permissions policy to the user (e.g., `AmazonEC2FullAccess`, `AmazonRDSFullAccess`, etc.).
9. Click on "Next: Tags" (optional) and add any tags if needed.
10. Click on "Next: Review".
11. Review the user details and permissions, then click on "Create user".
12. Note down the "Access key ID" and "Secret access key" displayed on the next screen. These credentials will be used by Terraform to authenticate with AWS.

### 2. Configure AWS Credentials

#### Using Environment Variables

Set the following environment variables with the access key ID and secret access key of the IAM user:


export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"

#### Using AWS Credentials File

1. Create a credentials file named `credentials` in the `.aws` directory in your home directory (e.g., `~/.aws/credentials`).
2. Add the access key ID and secret access key of the IAM user to the credentials file:


   [default]
   aws_access_key_id = your-access-key-id
   aws_secret_access_key = your-secret-access-key


### 3. Configure Terraform

In your Terraform configuration files (e.g., `main.tf`, `variables.tf`), specify the AWS provider and region:


provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}


## Verification

To verify that Terraform has access to AWS:

1. Run `terraform init` in your Terraform project directory to initialize Terraform.
2. Run `terraform plan` to create an execution plan and verify that Terraform can authenticate with AWS.
3. If the plan looks correct, apply the changes using `terraform apply` to create or update resources on AWS.

With these steps, you have successfully configured Terraform with AWS access, allowing it to manage AWS resources. Remember to follow security best practices and restrict permissions to the minimum required for your Terraform operations.
