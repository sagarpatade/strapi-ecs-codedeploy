# Strapi ECS Infrastructure & CodeDeploy Project

This repository contains the Infrastructure as Code (IaC) and deployment configurations for running a Strapi application on AWS ECS Fargate. It includes the successful configurations used to upgrade system resources and resolve complex networking and IAM permission issues.

---

Loom Video: https://www.loom.com/share/38f0c5dc1efe49159bc2d703ed858545


## 🚀 Project Overview
* **Application:** Strapi (Headless CMS)
* **Platform:** AWS ECS (Fargate)
* **CI/CD:** AWS CodeDeploy
* **Infrastructure:** Terraform
* **Resources:** 1024 CPU / 2048 Memory

---

## 🛠️ Problems Solved
During the deployment, several critical blockers were resolved:
* **Out of Memory (OOM):** Scaled resources from 512MB to 2GB RAM to prevent container crashes.
* **IAM Permissions:** Fixed the ECS Task Execution Role to allow correct image pulling from ECR.
* **VPC Networking:** Aligned subnets to a single VPC to resolve `InvalidSubnetID.NotFound` errors.
* **Application Secrets:** Injected `ADMIN_JWT_SECRET` and `JWT_SECRET` into the task definition to enable successful startup.

---

## 📋 Prerequisites
* AWS CLI configured with appropriate permissions.
* Terraform installed locally.
* A GitHub account with the `strapi-ecs-codedeploy` repository.

---

## 🏃 How to Run the App

### 1. Initialize Infrastructure
Navigate to the `terraform/` directory and run:
`terraform init`
`terraform apply`

### 2. Register the Task Definition
Register the working task definition (Revision 244) using the AWS CLI:
`aws ecs register-task-definition --cli-input-json file://taskdef.json`

### 3. Deploy via CodeDeploy
Use the provided `appspec.json` content in the CodeDeploy console to shift traffic to the new revision:
* **Application Name:** StrapiApp
* **Deployment Group:** strapi-dg-sagar

### 4. Access the Application
The application is accessible through the Load Balancer DNS on Port 80:
`http://strapi-alb-1521386178.us-east-1.elb.amazonaws.com/admin`

---

## 🔒 Security Note
Security Group `sg-06ca30c948083f1d7` is configured to allow inbound traffic on port **1337** for application communication.

---

## 📂 Repository Structure
* `/terraform`: Infrastructure as Code files.
* `taskdef.json`: Working ECS Task Definition (Revision 244).
* `appspec.json`: Configuration for AWS CodeDeploy.
