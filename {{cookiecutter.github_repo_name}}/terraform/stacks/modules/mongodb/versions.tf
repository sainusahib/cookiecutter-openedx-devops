#------------------------------------------------------------------------------
# written by: Lawrence McDaniel
#             https://lawrencemcdaniel.com/
#
# date: Aug-2022
#
# usage: create a remote MongoDB server with access limited to the VPC.
#------------------------------------------------------------------------------
terraform {
  required_version = "{{ cookiecutter.terraform_required_version }}"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "{{ cookiecutter.terraform_provider_hashicorp_local_version }}"
    }
    random = {
      source  = "hashicorp/random"
      version = "{{ cookiecutter.terraform_provider_hashicorp_random_version }}"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "{{ cookiecutter.terraform_provider_hashicorp_aws_version }}"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "{{ cookiecutter.terraform_provider_kubernetes_version }}"
    }
  }
}
