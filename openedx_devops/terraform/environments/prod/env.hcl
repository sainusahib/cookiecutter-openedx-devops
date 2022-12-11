#------------------------------------------------------------------------------
# written by: Lawrence McDaniel
#             https://lawrencemcdaniel.com/
#
# date: Feb-2022
#
# usage: create environment-level parameters, exposed to all
#        Terragrunt modules in this enironment.
#------------------------------------------------------------------------------
locals {
  global_vars = read_terragrunt_config(find_in_parent_folders("global.hcl"))

  environment               = "prod"
  environment_subdomain     = "courses"
  environment_domain        = "${local.environment_subdomain}.${local.global_vars.locals.root_domain}"
  environment_namespace     = "${local.global_vars.locals.platform_name}-${local.global_vars.locals.platform_region}-${local.environment}"
  shared_resource_namespace = "${local.global_vars.locals.platform_name}-${local.global_vars.locals.platform_region}-${local.global_vars.locals.shared_resource_identifier}"
  db_prefix                 = replace(replace("${local.global_vars.locals.platform_name}_${local.environment}", ".", ""), "-", "")

  # AWS instance sizing
  redis_node_type      = "cache.t2.small"

  tags = {
    Environment = local.environment
  }

}
