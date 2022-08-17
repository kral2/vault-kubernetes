terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.7.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.12.1"
    }
  }
}

provider "vault" {}

provider "kubernetes" {
    config_path = "~/.kube/config"
    config_context = "minikube"
}