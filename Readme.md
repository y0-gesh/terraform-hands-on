# Terraform Core Workflow & Concepts (Hands-On Guide)

This document provides a **complete, professional overview of Terraform**, including its core concepts, workflow, command lifecycle, and operational best practices when managing infrastructure on **AWS**.

Terraform enforces a **plan-before-apply** model.  
Skipping steps or executing commands blindly leads to **state drift, broken environments, and production outages**.

This guide reflects how Terraform is used in **real-world DevOps and Cloud teams**.

---

## 📌 What Is Terraform?

Terraform is an **Infrastructure as Code (IaC)** tool by HashiCorp that allows you to define, provision, and manage infrastructure using **declarative configuration files**.

Key characteristics:
- Declarative (you define *what*, Terraform decides *how*)
- Cloud-agnostic
- State-driven
- Idempotent
- Version-controlled infrastructure

---

## 🎯 Objectives

- Understand Terraform architecture and workflow
- Learn Infrastructure as Code (IaC) principles
- Provision and manage cloud infrastructure using Terraform
- Practice real-world use cases with reusable modules
- Follow industry-standard DevOps best practices

---

## 🛠️ Technologies & Tools

- **Terraform**
- **HashiCorp Configuration Language (HCL)**
- **AWS (Primary Cloud Provider)**
- **AWS CLI**
- **Git & GitHub**
- **Linux / Bash / CLI Tools**

---

## 📚 References

- Terraform Documentation  
  https://developer.hashicorp.com/terraform

- Terraform AWS Provider  
  https://registry.terraform.io/providers/hashicorp/aws/latest

- AWS CLI Environment Configuration  
  https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html

- Terraform Tutorial Video  
  https://www.youtube.com/watch?v=4JYtAf4M88Y

---

## 📂 Repository Structure

```text
terraform-hands-on/
│
├── basics/                 # Terraform workflow fundamentals
├── providers/              # Provider configurations
├── resources/              # AWS resource definitions
├── variables/              # Input variables & outputs
├── modules/                # Reusable Terraform modules
├── environments/           # Dev / Staging / Prod environments
├── state-management/       # Backend & remote state configs
├── examples/               # Practical hands-on examples
└── README.md
```

## 🔁 Terraform Core Workflow

Terraform follows a **strict execution lifecycle**:

```base
terraform init 
terraform validate 
terraform plan 
terraform apply
```

This sequence is **mandatory in professional environments**.

---

## 1️⃣ terraform init

### Purpose

Initializes a Terraform working directory.

### What It Does

- Downloads required providers (e.g., AWS)
    
- Initializes the backend (local or remote)
    
- Prepares `.terraform/` directory
    
- Locks provider versions

### When to Run

- First time in a directory
    
- After adding or modifying providers
    
- After backend changes
    
- After pulling updated Terraform code

### Command

```base
terraform init
```

### Expected Result

- `.terraform/` directory created
    
- Providers installed
    
- Backend successfully configured

### Important Notes

- Does **not** create infrastructure
    
- Does **not** validate AWS credentials
    
- Safe to run multiple times

---

## 2️⃣ terraform validate

### Purpose

Performs **static validation** of Terraform configuration files.

### What It Checks

- `.tf` file syntax
    
- Argument types
    
- Required attributes
    
- Provider & resource block structure

### What It Does NOT Check

- AWS credentials
    
- Resource existence
    
- Logical correctness

### Command

```base
terraform validate
```

### Expected Output

`Success! The configuration is valid.`

### When to Run

- After writing or modifying Terraform code
    
- Before running `terraform plan`

---

## 3️⃣ terraform plan

### Purpose

Creates an **execution plan** showing exactly what Terraform will change.

### What It Does

- Compares:
    
    - Terraform configuration
        
    - Current state file
        
    - Existing AWS infrastructure
        
- Calculates actions:
    
    - Create (`+`)
        
    - Update (`~`)
        
    - Destroy (`-`)
        
    - No change

### Command

```base
terraform plan
```

### Expected Result

A detailed diff of infrastructure changes.

### Why This Is Critical

- Prevents accidental deletions
    
- Enables peer review
    
- Mandatory for CI/CD pipelines
    
- Required before `terraform apply`

### Important Notes

- Read-only operation
    
- Makes **no changes** to AWS

---

## 4️⃣ terraform apply

### Purpose

Applies the planned changes to AWS.

### What It Does

- Executes the plan
    
- Calls AWS APIs
    
- Creates, updates, or deletes resources
    
- Updates the Terraform state file

### Command

```base
terraform apply
```

Terraform prompts for confirmation:

`Do you want to perform these actions? Enter a value: yes`

### Expected Result

- Infrastructure created or modified in AWS
    
- State file updated accurately

### Critical Warnings

- Modifies **real infrastructure**
    
- Requires valid AWS credentials
    
- Must never be run without reviewing the plan

---

## 🔐 AWS Authentication Requirements

Terraform does **not** manage credentials.

Authentication must be provided via:

- Environment variables
    
- AWS CLI configuration
    
- IAM roles (recommended)

Example:

```base
export AWS_ACCESS_KEY_ID=xxxx 
export AWS_SECRET_ACCESS_KEY=xxxx 
export AWS_DEFAULT_REGION=ap-south-1
```

---

## 🗂️ Terraform State Management

- State tracks real infrastructure
    
- Enables change detection
    
- Must be stored securely

### Best Practices

- Use **remote backends** (S3 + DynamoDB)
    
- Never commit `.tfstate` files
    
- Enable state locking
    
- Restrict access via IAM