# Cloud Operations Control Plane

> **Flagship CloudOps / Platform Engineering Project**

---

## Overview

The **Cloud Operations Control Plane** is an internal, platform-style system built on AWS to improve **governance, operational hygiene, cost control, and visibility** across cloud infrastructure.

This project mirrors how **real CloudOps and Platform Engineering teams** build lightweight internal tooling to manage growing AWS environments.

🔹 This is **not an application**.
🔹 It is an **operations platform**.

---

## What Problem This Solves

As AWS environments scale, teams commonly face:

* Lack of visibility into deployed resources
* Orphaned resources causing silent cost leaks
* Manual, reactive operational workflows
* Weak governance and auditability

This control plane provides a **safe, automated foundation** to address these problems.

---

## High-Level Architecture

```
EventBridge (Schedule)
        │
        ▼
AWS Lambda (Inventory & Hygiene)
        │   IAM (Least Privilege)
        ▼
Amazon S3 (Versioned Reports)
        │
        ▼
Future Consumers
(Governance, Cost, Dashboards, Alerts)
```

**Key design choices:**

* Fully serverless (no EC2, no cron)
* Least-privilege IAM
* Read-only, detection-first automation
* Durable, auditable S3 storage

---

## What Is Implemented

### Phase 1 – Governance & Inventory ✅

* Terraform-based AWS foundation with remote state & locking
* IAM + STS assume-role access model
* Scheduled inventory collection using **Lambda + EventBridge**
* Inventory captured as time-stamped JSON in **Amazon S3**
* Resources inventoried:

  * EC2 instances
  * EBS volumes
  * EBS snapshots
  * IAM users

---

### Phase 2 – Cost & Hygiene Automation ✅

Extended the control plane to proactively detect **cost-leaking resources**:

* **Orphaned EBS volumes**

  * Volumes in `available` state (unattached)
* **Aged EBS snapshots**

  * Snapshots older than 30 days

📌 Design principles:

* Detection only (no auto-deletion)
* Fully auditable outputs
* Safe-by-default automation

Reports are written to S3 for historical analysis and future automation.

---

## Repository Structure

```
cloud-operations-control-plane/
├── terraform/               # Infrastructure as Code
│   └── envs/dev/
├── lambdas/                 # Serverless automation logic
├── scripts/                 # Local helper scripts
├── trust-policy.json        # IAM trust relationship
├── .gitignore
└── README.md
```

---

## Tools & Technologies

* AWS Lambda
* Amazon EventBridge
* Amazon S3
* AWS IAM & STS
* Terraform
* Python (boto3)
* Amazon CloudWatch Logs

---

## Why This Project Matters

This project demonstrates:

* Platform engineering mindset
* Governance-first cloud automation
* Cost awareness and hygiene
* Safe, production-oriented design
* Real-world Terraform and AWS workflows

It focuses on **operability and reliability**, not application features.

---

## Resume / Interview Summary

> Designed and implemented a Cloud Operations Control Plane using Terraform and AWS serverless services to automate resource inventory and proactively detect cost-leaking resources through scheduled, auditable hygiene automation.

---

## Project Status

✅ **Intentionally complete at Phase 2**

This project is deliberately scoped to demonstrate core **CloudOps and Platform Engineering** skills without over-engineering. Future extensions are possible but not required.

---
