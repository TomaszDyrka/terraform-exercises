# EPAM Mentoring - Terraform Module

This repository contains my Terraform configurations and tasks completed during the EPAM Cloud & DevOps Mentoring Program. The focus of these projects is on implementing Infrastructure as Code (IaC) best practices using Google Cloud Platform (GCP).

## 🚀 Projects Included

*   **Modular Architecture Implementation**: Refactoring standard, flat Terraform configurations into logical, reusable modules to maintain clean and scalable infrastructure code.
*   **Load Balancer Configuration**: Provisioning and configuring Cloud Load Balancing to efficiently distribute incoming traffic across backend instance groups.
*   **Blue/Green Deployment Simulation**: Utilizing traffic splitting and weighted backend services to simulate a zero-downtime Blue/Green deployment strategy.

## ⚠️ Important Note on Infrastructure State

Please note that **not all resources referenced in this repository were provisioned from scratch using these scripts**. 

As part of the mentoring exercises, a portion of the baseline infrastructure was prepared beforehand and integrated into the environment using the `terraform import` command. Because these scripts rely on that pre-existing state, running a direct `terraform apply` on a fresh environment may require manual state adjustments or the manual provisioning of those foundational resources first.

## 🛠️ Technologies & Tools

*   **Terraform** (Modules, Remote State, Resource Import)
*   **Google Cloud Platform (GCP)** (Compute Engine, Cloud Load Balancing)
