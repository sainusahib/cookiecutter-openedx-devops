#------------------------------------------------------------------------------
# written by: Lawrence McDaniel
#             https://lawrencemcdaniel.com/
#
# date: Feb-2022
#
# usage: create stack-level parameters, exposed to all
#        Terragrunt modules in this enironment.
#------------------------------------------------------------------------------
locals {
  global_vars = read_terragrunt_config(find_in_parent_folders("global.hcl"))

  stack           = local.global_vars.locals.shared_resource_identifier
  stack_namespace = "${local.global_vars.locals.platform_name}-${local.global_vars.locals.platform_region}-${local.global_vars.locals.shared_resource_identifier}"

  # AWS instance sizing
  mysql_instance_class = "db.t2.small"
  mysql_allocated_storage=10

  redis_node_type      = "cache.t2.small"

  # MongoDB EC2 instance sizing
  mongodb_instance_type    = "t3.medium"
  mongodb_allocated_storage = 10
  

  # Bastion EC2 instance sizing
  bastion_instance_type    = "t3.micro"
  bastion_allocated_storage = 50
  

  #----------------------------------------------------------------------------
  # AWS Elastic Kubernetes service
  # Scaling options
  #
  # About AWS EC2 a1 series virtual servers:
  # ----------------------------------------
  # Amazon EC2 A1 instances deliver significant cost savings and are ideally
  # suited for scale-out and Arm-based workloads that are supported by the
  # extensive Arm ecosystem. A1 instances are the first EC2 instances powered
  # by AWS Graviton Processors that feature 64-bit Arm Neoverse cores and custom
  # silicon designed by AWS.
  #
  #   a1.medium:     1 vCPU 2gb
  #   a1.large:      2 vCPU 4gb
  #   a1.xlarge:     4 vCPU 8gb
  #   a1.2xlarge:    8 vCPU 16gb
  #   a1.4xlarge:   16 vCPU 32gb
  #   a1.metal:     16 physical cpus 32gb
  #
  # see: https://aws.amazon.com/ec2/instance-types/
  #----------------------------------------------------------------------------
  kubernetes_version = "1.24"
  eks_worker_group_instance_type = "t3.xlarge"
  eks_worker_group_min_size = 0
  eks_worker_group_max_size = 1
  eks_worker_group_desired_size = 0

  eks_karpenter_group_instance_type = "t3.large"
  eks_karpenter_group_min_size = 3
  eks_karpenter_group_max_size =  10
  eks_karpenter_group_desired_size =  3

  tags = {
    Stack = local.stack
  }

}
