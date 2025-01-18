# Kubernetes Cluster on DigitalOcean with Terraform

This repository contains Terraform code to provision a Kubernetes cluster with 4 nodes on DigitalOcean.

## Prerequisites

- [Terraform installed](https://www.digitalocean.com/community/tutorials/how-to-use-terraform-with-digitalocean#step-1-installing-terraform)

- [DigitalOcean API Token](https://docs.digitalocean.com/reference/api/create-personal-access-token/)

## Setup Instructions

1. Clone the Repository

    ```bash
    git clone https://github.com/arthurkretzer/digitalocean-k8s-iac.git
    cd digitalocean-k8s-iac
    ```

2. Configure Variables

    Create a env.tfvars file and add the following content:

    ```bash
    do_token = "your_digitalocean_token"
    region   = "nyc1"
    node_size = "s-2vcpu-2gb"
    ```

3. Use Terraform

    Create the cluster by initializing, planning and applying terraform.

    ```bash
    terraform init
    terraform plan -var-file="env.tfvars"
    terraform apply -var-file="env.tfvars"
    ```

## Outputs

- **Kubeconfig**: Kubernetes configuration file for cluster access
- **Cluster Endpoint**: URL to access the Kubernetes API server

## License

This project is licensed under the Apache License v2.0.
