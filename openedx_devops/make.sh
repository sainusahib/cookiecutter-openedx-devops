#!/bin/sh
#------------------------------------------------------------------------------
# written by:   mcdaniel
#               https://lawrencemcdaniel.com
#
# date:         mar-2022
#
# usage:        Re-runs the Cookiecutter for this repository.
#------------------------------------------------------------------------------

GITHUB_REPO="gh:lpm0073/cookiecutter-openedx-devops"
GITHUB_BRANCH="main"
OUTPUT_FOLDER="../"

cookiecutter --checkout $GITHUB_BRANCH \
             --output-dir $OUTPUT_FOLDER \
             --overwrite-if-exists \
             --no-input \
             $GITHUB_REPO \
             ci_deploy_install_credentials_server=N \
             ci_deploy_install_license_manager=Y \
             ci_deploy_install_discovery_service=Y \
             ci_deploy_install_mfe_service=Y \
             ci_deploy_install_notes_service=Y \
             ci_deploy_install_ecommerce_service=Y \
             global_platform_name=tutorlabs \
             global_platform_region=global \
             global_aws_region=eu-west-2 \
             global_account_id=669103529732 \
             global_root_domain=tutorlabs.cloud \
             global_aws_route53_hosted_zone_id=Z0025202252VR1DHZSK9 \
             environment_name=prod \
             environment_subdomain=courses \
             eks_worker_group_instance_type=t3.xlarge \
             eks_worker_group_min_size=0 \
             eks_worker_group_max_size=1 \
             eks_worker_group_desired_size=0 \
             eks_karpenter_group_instance_type=t3.large \
             eks_karpenter_group_min_size=3 \
             eks_karpenter_group_max_size=10 \
             eks_karpenter_group_desired_size=3 \
             mysql_instance_class=db.t2.small \
             mysql_allocated_storage=10 \
             redis_node_type=cache.t2.small \
             stack_add_bastion=N \
             stack_add_remote_mongodb=N \
             
