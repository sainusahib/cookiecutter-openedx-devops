#------------------------------------------------------------------------------
# written by: Miguel Afonso
#             https://www.linkedin.com/in/mmafonso/
#
# date: aug-2022
#
# usage: create environment connection resources for remote MongoDB instance.
#------------------------------------------------------------------------------
locals {
  # Automatically load environment-level variables
  global_vars      = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  resource_name             = local.environment_vars.locals.shared_resource_namespace
  environment_domain        = local.environment_vars.locals.environment_domain
  environment_namespace     = local.environment_vars.locals.environment_namespace
  shared_resource_namespace = local.environment_vars.locals.shared_resource_namespace
  db_prefix                 = local.environment_vars.locals.db_prefix
}

dependencies {
  paths = [
    "../../../stacks/{{ cookiecutter.global_platform_shared_resource_identifier }}/vpc",
    "../../../stacks/{{ cookiecutter.global_platform_shared_resource_identifier }}/kubernetes",
    "../../../stacks/{{ cookiecutter.global_platform_shared_resource_identifier }}/mongodb",
    "../kubernetes_secrets"
  ]
}

dependency "vpc" {
  config_path = "../../../stacks/{{ cookiecutter.global_platform_shared_resource_identifier }}/vpc"

  # Configure mock outputs for the `validate` and `init` commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs = {
    vpc_id           = "fake-vpc-id"
    public_subnets   = ["fake-public-subnet-01", "fake-public-subnet-02"]
    private_subnets  = ["fake-private-subnet-01", "fake-private-subnet-02"]
    database_subnets = ["fake-database-subnet-01", "fake-database-subnet-02"]
  }

}

dependency "kubernetes" {
  config_path = "../../../stacks/{{ cookiecutter.global_platform_shared_resource_identifier }}/kubernetes"

  # Configure mock outputs for the `validate` and `init` commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs = {
    cluster_arn           = "fake-cluster-arn"
    cluster_certificate_authority_data = "fake-cert"
    cluster_endpoint = "fake-cluster-endpoint"
    cluster_id = "fake-cluster-id"
    cluster_oidc_issuer_url = "fake-oidc-issuer-url"
    cluster_platform_version = "fake-cluster-version"
    cluster_security_group_arn = "fake-security-group-arn"
    cluster_security_group_id = "fake-security-group-id"
    cluster_status = "fake-cluster-status"
    cluster_version = "fake-cluster-version"
    eks_managed_node_groups = "fake-managed-node-group"
    fargate_profiles = "fake-fargate-profile"
    node_security_group_arn = "fake-security-group-arn"
    node_security_group_id = "fake-security-group-id"
    oidc_provider = "fake-oidc-provider"
    oidc_provider_arn = "fake-provider-arn"
  }

}

dependency "mongodb" {
  config_path = "../../../stacks/{{ cookiecutter.global_platform_shared_resource_identifier }}/mongodb"

  # Configure mock outputs for the `validate` and `init` commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
  mock_outputs = {
    mongodb_internal_ip = "fake-mongodb-private-ip"
  }

}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../modules//mongodb"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  db_prefix                 = local.db_prefix
  resource_name             = local.resource_name
  environment_domain        = local.environment_domain
  environment_namespace     = local.environment_namespace
  shared_resource_namespace = local.shared_resource_namespace
}
