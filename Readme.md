# Terraform Core Workflow Documentation

This document describes the **mandatory Terraform command sequence** used to initialize, validate, review, and apply infrastructure changes on AWS.

Terraform follows a **plan-before-apply** model. Skipping steps or running commands blindly leads to broken environments and unstable infrastructure.

---

## Resources

https://developer.hashicorp.com/terraform
https://www.youtube.com/watch?v=4JYtAf4M88Y
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html
https://registry.terraform.io/providers/hashicorp/aws/latest

---

## 📌 Objectives

- Understand Terraform core concepts and workflow
- Learn Infrastructure as Code (IaC) principles
- Provision and manage cloud infrastructure using Terraform
- Practice real-world use cases with reusable modules
- Follow industry-standard best practices

---

## 🛠️ Technologies & Tools

- **Terraform**
- **HashiCorp Configuration Language (HCL)**
- **Cloud Providers** (AWS / Azure / GCP – as applicable)
- **Git & GitHub**
- **CLI Tools**

---

## 📂 Repository Structure
terraform-hands-on/
│
├── basics/ # Terraform basics (init, plan, apply)
├── providers/ # Provider configurations
├── resources/ # Common Terraform resources
├── variables/ # Variables and outputs
├── modules/ # Reusable Terraform modules
├── environments/ # Dev / staging / prod setups
├── state-management/ # Backend and state handling
├── examples/ # Hands-on examples
└── README.md
---

## 1. `terraform init`

### Purpose
Initializes the Terraform working directory.

### What it does
- Downloads required **providers** (for example, AWS)
- Initializes the **backend** (local or remote state)
- Prepares the directory for further Terraform operations

### When to run
- First time working in a Terraform directory
- After adding or changing providers
- After modifying backend configuration
- After pulling new Terraform code

### Command
```bash
terraform init
```

### Expected result

- `.terraform/` directory is created
    
- Providers are installed
    
- Backend is successfully configured
    

### Notes

- This command **does not** create or modify any infrastructure.
    
- It **does not validate AWS credentials**.
    

---

## 2. `terraform validate`

### Purpose

Validates Terraform configuration files for **syntax and structural correctness**.

### What it checks

- `.tf` file syntax
    
- Argument types
    
- Required attributes
    
- Provider and resource block structure
    

### What it does NOT check

- AWS credentials
    
- Resource existence
    
- Logical correctness of infrastructure design
    

### Command

```
terraform validate
```

### Expected result

`Success! The configuration is valid.`

### When to run

- After writing or modifying `.tf` files
    
- Before running `terraform plan`
    

### Notes

- This is a **static check only**.
    
- Passing validation does not guarantee a successful deployment.
    

---

## 3. `terraform plan`

### Purpose

Generates an **execution plan** showing what Terraform **will change** in AWS.

### What it does

- Compares:
    
    - Current infrastructure state
        
    - Terraform state file
        
    - Current `.tf` configuration
        
- Calculates actions:
    
    - Create
        
    - Update
        
    - Delete
        
    - No change

### Command

```
terraform plan
```

### Expected result

A detailed diff showing:

- Resources to be created
    
- Resources to be modified
    
- Resources to be destroyed

### Output indicators

- `+` create
    
- `~` update
    
- `-` destroy

### When to run

- Before **every** `terraform apply`
    
- During code review
    
- Before merging Terraform changes

### Notes

- This is a **read-only** operation.
    
- No changes are made to AWS.

---

## 4. `terraform apply`

### Purpose

Applies the planned infrastructure changes to AWS.

### What it does

- Executes the plan
    
- Calls AWS APIs
    
- Creates, updates, or deletes resources
    
- Updates the Terraform state file

### Command

```
terraform apply
```


Terraform will prompt for confirmation:

`Do you want to perform these actions?   Enter a value: yes`

Type:

`yes`

### Expected result

- Infrastructure is created or updated in AWS
    
- Terraform state is updated

### Notes

- This command **modifies real infrastructure**.
    
- Requires **valid AWS credentials**.
    
- Must never be run without reviewing the plan.

---

## Recommended Execution Order

`terraform init terraform validate terraform plan terraform apply`

This order is **non-negotiable** in professional environments.

---

## Important Warnings

- Never run `terraform apply` without reviewing `terraform plan`
    
- Never commit Terraform state files to version control
    
- Never hard-code AWS credentials in `.tf` files
    
- Never use placeholder or example AWS keys