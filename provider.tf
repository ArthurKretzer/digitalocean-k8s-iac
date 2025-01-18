terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

provider "digitalocean" {
  token = var.do_token
}

variable "region" {
  description = "Region to deploy the Kubernetes cluster"
  type        = string
  default     = "nyc1"
}

variable "node_size" {
  description = "Droplet size for Kubernetes nodes"
  type        = string
  default     = "s-2vcpu-2gb"
}

resource "digitalocean_kubernetes_cluster" "k8s_cluster" {
  name    = "k8s-cluster"
  region  = var.region
  version = "1.31.1-do.5"

  node_pool {
    name       = "worker-pool"
    size       = var.node_size
    node_count = 4
    auto_scale = false
  }
}

output "kubeconfig" {
  description = "Kubernetes config file"
  value       = digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].raw_config
  sensitive   = true
}

output "cluster_endpoint" {
  description = "Kubernetes cluster endpoint"
  value       = digitalocean_kubernetes_cluster.k8s_cluster.endpoint
}
