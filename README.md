# Cloud Operations Control Plane (Flagship Project)

## Overview

The **Cloud Operations Control Plane** is an internal platform-style system designed to improve **governance, operational hygiene, automation, and visibility** across AWS infrastructure. It mirrors how real CloudOps / Platform Engineering teams build lightweight but powerful internal tooling.

This project is intentionally not an application. It is an **operations platform**.

---

## High-Level Architecture

```
+---------------------+
|   AWS EventBridge   |
|  (Scheduled Rules) |
+----------+----------+
           |
           v
+---------------------+        IAM (Least Privilege)
| AWS Lambda          |-----------------------------------+
| Inventory Collector |                                   |
| (Python)            |                                   |
+----------+----------+                                   |
           |                                              |
           v                                              v
+---------------------------+          +-------------------------+
| Amazon S3                 |          | AWS APIs                |
| Inventory Bucket          |          | - EC2                   |
| (Versioned, Private)      |          | - EBS / Snapshots       |
|                           |          | - IAM                   |
+---------------------------+          +-------------------------+
           |
           v
+---------------------------+
| Downstream Consumers      |
| (Future Phases)           |
| - Governance checks       |
| - Dashboards              |
| - Alerts & Automation     |
+---------------------------+
```

---

## What Is Implemented (Phase 1 – COMPLETE)

### 1. Identity & Access Foundation

* AWS IAM user → role assumption using STS
* Dedicated **CloudOps Admin role**
* Least-privilege IAM policies
* WSL-based isolated execution environment

### 2. Terraform Foundation

* Remote Terraform state stored in S3
* State locking enabled
* Backend and provider separated
* No local state or embedded credentials

### 3. Governance & Inventory (Core Pillar)

* Terraform-managed S3 inventory bucket

  * Versioning enabled
  * Public access blocked
  * Governance tags applied
* Inventory Lambda (Python):

  * Collects EC2 instance counts
  * Collects EBS volume counts
  * Collects snapshot counts
  * Collects IAM user counts
* Inventory written as JSON to S3
* EventBridge schedule for automated execution

---

## Tools & Technologies

* AWS Lambda
* Amazon S3
* Amazon EventBridge
* AWS IAM & STS
* Terraform
* Python (boto3)
* CloudWatch Logs

---

## Project Structure

```
Project01-CLOUD-OPS-CP/
├── terraform/
│   └── envs/dev/
│       ├── backend.tf
│       ├── provider.tf
│       ├── inventory.tf
│       ├── iam_inventory.tf
│       └── lambda_inventory.tf
├── lambdas/
│   ├── inventory_collector.py
│   └── inventory_collector.zip
├── docs/
├── dashboards/
├── runbooks/
└── README.md
```

---

## Why This Project Matters

This project demonstrates:

* Platform engineering thinking
* Governance-first automation
* Safe infrastructure practices
* Real-world AWS and Terraform workflows

It intentionally focuses on **operability**, not application features.

---

## Resume Summary

> Designed and implemented a cloud operations control plane using Terraform, AWS Lambda, IAM, EventBridge, and S3 to automate AWS resource inventory, enforce governance, and provide operational visibility.

---

## Roadmap (Next Phases)

### Phase 2 – Automation Engine

* Orphaned EBS and snapshot detection
* EC2 stop/start scheduling
* Snapshot cleanup automation

### Phase 3 – Visibility

* CloudWatch dashboards
* Inventory trend analysis
* Automation success/failure metrics

### Phase 4 – Incident Hooks

* IAM privilege change alerts
* Resource threshold alerts
* Event-driven notifications

---

## Status

**Phase 1 (Governance & Inventory): COMPLETE ✅**

