Tutor Open edX Production Devops Tools
======================================
.. image:: https://img.shields.io/badge/hack.d-Lawrence%20McDaniel-orange.svg
  :target: https://lawrencemcdaniel.com
  :alt: Hack.d Lawrence McDaniel

.. image:: https://img.shields.io/static/v1?logo=discourse&label=Forums&style=flat-square&color=ff0080&message=discuss.overhang.io
  :alt: Forums
  :target: https://discuss.openedx.org/

.. image:: https://img.shields.io/static/v1?logo=readthedocs&label=Documentation&style=flat-square&color=blue&message=docs.tutor.overhang.io
  :alt: Documentation
  :target: https://docs.tutor.overhang.io
|
.. image:: https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white
  :target: https://www.terraform.io/
  :alt: Terraform

.. image:: https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white
  :target: https://aws.amazon.com/
  :alt: AWS

.. image:: https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white
  :target: https://www.docker.com/
  :alt: Docker

.. image:: https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white
  :target: https://kubernetes.io/
  :alt: Kubernetes
|

.. image:: https://avatars.githubusercontent.com/u/40179672
  :target: https://openedx.org/
  :alt: OPEN edX
  :width: 75px
  :align: center

.. image:: https://overhang.io/static/img/tutor-logo.svg
  :target: https://docs.tutor.overhang.io/
  :alt: Tutor logo
  :width: 75px
  :align: center

|


This repository contains Terraform code and Github Actions workflows to deploy and manage a `Tutor <https://docs.tutor.overhang.io/>`_ Kubernetes-managed
production installation of Open edX that will automatically scale up, reliably supporting several hundred thousand learners.

**NEW IN VERSION 1.02: SPOT PRICING FOR EC2 INSTANCES** Save up to 75% off the cost of on-demand EC2 instances by using AWS' flexible `spot-pricing <https://aws.amazon.com/ec2/spot/pricing/>`_ .

**NEW IN VERSION 1.03: an optional fully-configured remote MongoDB server running on an EC2 instance. Set cookiecutter.stack_add_remote_mongodb=Y to choose this option.**

The Terraform scripts in this repo provide a 1-click means of creating / updating / destroying the following for each environment:

- LMS at https://courses.tutorlabs.cloud
- CMS at https://studio.courses.tutorlabs.cloud
- CDN at https://cdn.courses.tutorlabs.cloud linked to a public read-only S3 bucket named courses-tutorlabs-global-storage
- Grafana at https://grafana.courses.tutorlabs.cloud/login
  - user: admin
  - pwd: prom-operator
- public ssh access via a t2.micro Ubuntu 20.04 LTS bastion EC2 instance at bastion.courses.tutorlabs.cloud
- daily data backups archived into a private S3 bucket named prod-tutorlabs-global-mongodb-backup

You can also optionally automatically create additional environments for say, dev and test and QA and so forth.
These would result in environments like the following:

- LMS at https://dev.courses.tutorlabs.cloud
- CMS at https://studio.dev.courses-tutorlabs.cloud
- CDN at https://cdn.dev.courses.tutorlabs.cloud linked to an S3 bucket named dev-tutorlabs-global-storage
- daily data backups archived into an S3 bucket named dev-tutorlabs-global-mongodb-backup

Cookiecutter Manifest
------------------------

This repository was generated using `Cookiecutter <https://cookiecutter.readthedocs.io/>`_. Keep your repository up to date with the latest Terraform code and configuration versions of the Open edX application stack, AWS infrastructure services and api code libraries by occasionally re-generating the Cookiecutter template using this `make file <./make.sh>`_.

.. list-table:: Cookiecutter Version Control
  :widths: 75 20
  :header-rows: 1

  * - Software
    - Version
  * - `Open edX Named Release <https://edx.readthedocs.io/projects/edx-developer-docs/en/latest/named_releases.html>`_
    - stepwise
  * - `MySQL Server <https://www.mysql.com/>`_
    - 5.7.33
  * - `Redis Cache <https://redis.io/>`_
    - 6.x
  * - `Tutor Docker-based Open edX Installer <https://docs.tutor.overhang.io/>`_
    - latest stable
  * - `Tutor Plugin: Object storage for Open edX with S3 <https://github.com/hastexo/tutor-contrib-s3>`_
    - v1.0.0
  * - `Tutor Plugin: Discovery Service <https://github.com/overhangio/tutor-discovery>`_
    - latest stable
  * - `Tutor Plugin: Micro Front-end Service <https://github.com/overhangio/tutor-mfe>`_
    - latest stable
  * - `Tutor Plugin: Ecommerce Service <https://github.com/overhangio/tutor-ecommerce>`_
    - latest stable
  * - `Tutor Plugin: Notes Service <https://github.com/overhangio/tutor-notes>`_
    - latest stable
  * - `Tutor Plugin: Android Application <https://github.com/overhangio/tutor-android>`_
    - latest stable
  * - `Kubernetes Cluster <https://kubernetes.io/>`_
    - 1.24
  * - `Terraform <https://www.terraform.io/>`_
    - ~> 1.3
  * - `terraform-aws-modules/acm <https://registry.terraform.io/modules/terraform-aws-modules/acm/aws/latest>`_
    - ~> 4.3
  * - `terraform-aws-modules/cloudfront <https://registry.terraform.io/modules/terraform-aws-modules/cloudfront/aws/latest>`_
    - ~> 3.1
  * - `terraform-aws-modules/eks <https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest>`_
    - ~> 19.0
  * - `terraform-aws-modules/iam <https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest>`_
    - ~> 5.9
  * - `terraform-aws-modules/rds <https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest>`_
    - ~> 5.2
  * - `terraform-aws-modules/s3-bucket <https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest>`_
    - ~> 3.6
  * - `terraform-aws-modules/security-group <https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest>`_
    - ~> 4.16
  * - `terraform-aws-modules/vpc <https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest>`_
    - ~> 3.18
  * - Terraform `Helm cert-manager <https://charts.jetstack.io>`_
    - 1.9
  * - Terraform `Kubernetes Provider <https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs>`_
    - ~> 2.16
  * - Terraform `AWS Provider <https://registry.terraform.io/providers/hashicorp/aws/latest/docs>`_
    - ~> 4.45
  * - Terraform `Local Provider <https://registry.terraform.io/providers/hashicorp/local/latest/docs>`_
    - ~> 2.2
  * - Terraform `Random Provider <https://registry.terraform.io/providers/hashicorp/random/latest/docs>`_
    - ~> 3.4


Important Considerations
------------------------

- this code only works for AWS.
- the root domain tutorlabs.cloud must be hosted in `AWS Route53 <https://console.aws.amazon.com/route53/v2/hostedzones#>`_. Terraform will create several DNS entries inside of this hosted zone, and it will optionally create additional hosted zones (one for each additional optional environment) that will be linked to the hosted zone of your root domain.
- resources are deployed to this AWS region: ``eu-west-2``
- the Github Actions workflows depend on secrets `located here <settings> (see 'secrets/actions' from the left menu bar) `_
- the Github Actions use an AWS IAM key pair from `this manually-created user named *ci* <https://console.aws.amazon.com/iam/home#/users/ci?section=security_credentials>`_
- the collection of resources created by these scripts **will generate AWS costs of around $0.41 USD per hour ($10.00 USD per day)** while the platform is in a mostly-idle pre-production state. This cost will grow proportionally to your production work loads. You can view your `AWS Billing dashboard here <https://console.aws.amazon.com/billing/home?region=eu-west-2#/>`_
- **BE ADVISED** that `MySQL RDS <https://eu-west-2.console.aws.amazon.com/rds/home?region=eu-west-2#databases:>`_, `MongoDB <https://eu-west-2.console.aws.amazon.com/docdb/home?region=eu-west-2#subnetGroups>`_ and `Redis ElastiCache <https://eu-west-2.console.aws.amazon.com/elasticache/home?region=eu-west-2#redis:>`_ are vertically scaled **manually** and therefore require some insight and potential adjustments on your part. All of these services are defaulted to their minimum instance sizes which you can modify in the `environment configuration file <terraform/environments/prod/env.hcl>`_

Quick Start
-----------

I. Add Your Secret Credentials To This Repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Github Actions workflows in this repository depend on several `workflow secrets <settings>`_ including two sets of AWS IAM keypairs, one for CI workflows and another for the AWS Simple Email Service.
Additionally, they require a Github Personal Access Token (PAT) for a Github user account with all requisite privileges in this repository as well as any other repositories that are cloned during any of the build / installation pipelines.

.. image:: doc/repository-secrets.png
  :width: 700
  :alt: Github Repository Secrets

II. Configure Your Open edX Back End
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Set your `global parameters <terraform/environments/global.hcl>`_

.. code-block:: hcl

  locals {
    platform_name    = "tutorlabs"
    platform_region  = "global"
    root_domain      = "tutorlabs.cloud.ai"
    aws_region       = "eu-west-2"
    account_id       = "669103529732"
  }


Set your `production environment parameters <terraform/environments/prod/env.hcl>`_

.. code-block:: hcl

  locals {

  environment           = "courses"
  environment_domain    = "${local.environment}.${local.global_vars.locals.root_domain}"
  environment_namespace = "${local.environment}-${local.global_vars.locals.platform_name}-${local.global_vars.locals.platform_region}"


  # AWS infrastructure sizing

  mysql_instance_class            = "db.t2.small"
  redis_node_type                 = "cache.t2.small"
  eks_worker_group_instance_type  = "t3.xlarge"

  }



III. Build Your Open edX Backend
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The backend build procedure is automated using `Terragrunt <https://terragrunt.gruntwork.io/>`_ for `Terraform <https://www.terraform.io/>`_.
Installation instructions are avilable at both of these web sites.

Terraform scripts rely on the `AWS CLI (Command Line Interface) Tools <https://aws.amazon.com/cli/>`_. Installation instructions for Windows, macOS and Linux are available on this site.
We also recommend that you install `k9s <https://k9scli.io/>`_, a popular tool for adminstering a Kubernetes cluster.

.. code-block:: shell

  # -------------------------------------
  # to build the entire backend
  # -------------------------------------
  cd ./terraform/environments/prod/vpc
  terragrunt run-all init
  terragrunt run-all apply

  # -------------------------------------
  # or, to manage an individual resource
  # -------------------------------------
  cd ./terraform/environments/prod/mongodb
  terragrunt init
  terragrunt validate
  terragrunt plan
  terragrunt apply
  terragrunt destroy

.. image:: doc/terragrunt-init.png
  :width: 900
  :alt: terragrunt run-all init


IV. Connect To Your backend Services
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Terraform creates friendly subdomain names for any of the backend services which you are likely to connect: Cloudfront, MySQL, Mongo and Redis.
The ssh private pem key for accessing the EC2 Bastion instance is stored in Kubernetes secrets in the openedx namespace. Additionally, passwords for the root/admin accounts are accessible from Kubernetes Secrets. Note that each of MySQL, MongoDB and Redis reside in private subnets. These services can only be accessed on the command line from the Bastion.

.. code-block:: shell

  ssh bastion.courses.tutorlabs.cloud -i path/to/tutorlabs-global-live-bastion.pem

  mysql -h mysql.courses.tutorlabs.cloud -u root -p

  mongo --port 27017 --host mongo.master.courses.tutorlabs.cloud -u root -p
  mongo --port 27017 --host mongo.reader.courses.tutorlabs.cloud -u root -p

  redis-cli -h redis.primary.courses.tutorlabs.cloud -p 6379

Specifically with regard to MySQL, several 3rd party analytics tools provide out-of-the-box connectivity to MySQL via a bastion server. Following is an example of how to connect to your MySQL environment using MySQL Workbench.

.. image:: doc/mysql-workbench.png
  :width: 700
  :alt: Connecting to MySQL Workbench

V. Add more Kubernetes admins
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default your AWS IAM user account will be the only user who can view, interact with and manage your new Kubernetes cluster. Other IAM users with admin permissions will still need to be explicitly added to the list of Kluster admins.
If you're new to Kubernetes then you'll find detailed technical how-to instructions in the AWS EKS documentation, `Enabling IAM user and role access to your cluster <https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html>`_.
You'll need kubectl in order to modify the aws-auth pod in your Kubernets cluster.

**Note that since June-2022 the AWS EKS Kubernetes cluster configuration excludes public api access. This means that kubectl is only accessible via the bastion, from inside of the AWS VPC on the private subnets.
The convenience script /scripts/bastion-config.sh installs all of the Ubuntu packages and additional software that you'll need to connect to the k8s cluster using kubectl and k9s. You'll also need to
configure aws cli with an IAM key and secret with the requisite admin permissions.**

.. code-block:: bash

    kubectl edit -n kube-system configmap/aws-auth

Following is an example aws-auth configMap with additional IAM user accounts added to the admin "masters" group.

.. code-block:: yaml

    # Please edit the object below. Lines beginning with a '#' will be ignored,
    # and an empty file will abort the edit. If an error occurs while saving this file will be
    # reopened with the relevant failures.
    #
    apiVersion: v1
    data:
      mapRoles: |
        - groups:
          - system:bootstrappers
          - system:nodes
          rolearn: arn:aws:iam::012345678942:role/default-eks-node-group-20220518182244174100000002
          username: system:node:{{EC2PrivateDNSName}}
      mapUsers: |
        - groups:
          - system:masters
          userarn: arn:aws:iam::012345678942:user/lawrence.mcdaniel
          username: lawrence.mcdaniel
        - groups:
          - system:masters
          userarn: arn:aws:iam::012345678942:user/ci
          username: ci
        - groups:
          - system:masters
          userarn: arn:aws:iam::012345678942:user/user
          username: user
    kind: ConfigMap
    metadata:
      creationTimestamp: "2022-05-18T18:38:29Z"
      name: aws-auth
      namespace: kube-system
      resourceVersion: "499488"
      uid: 52d6e7fd-01b7-4c80-b831-b971507e5228


Continuous Integration (CI)
---------------------------

Both the Build as well as the Deploy workflows were pre-configured based on your responses to the Cookiecutter questionnaire. Look for these two files in `.github/workflows <.github/workflows>`_. You'll find additional Open edX deployment and configuration files in `ci/tutor-build <ci/tutor-build>`_ and `ci/tutor-deploy <ci/tutor-deploy>`_


I. Build your Tutor Docker Image
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use `this automated Github Actions workflow <https://github.com/sainusahib/openedx_devops/actions/workflows/tutor_build_image.yml>`_ to build a customized Open edX Docker container based on the latest stable version of Open edX (current stepwise) and
your Open edX custom theme repository and Open edX plugin repository. Your new Docker image will be automatically uploaded to `AWS Amazon Elastic Container Registry <https://eu-west-2.console.aws.amazon.com/ecr/repositories?region=eu-west-2>`_


II. Deploy your Docker Image to a Kubernetes Cluster
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use `this automated Github Actions workflow <https://github.com/sainusahib/openedx_devops/actions/workflows/tutor_deploy_prod.yml>`_ to deploy your customized Docker container to a Kubernetes Cluster.
Open edX LMS and Studio configuration parameters are located `here <ci/tutor-deploy/environments/prod/settings_merge.json>`_.


About The Open edX Platform Back End
------------------------------------

The scripts in the `terraform <terraform>`_ folder provide 1-click functionality to create and manage all resources in your AWS account.
These scripts generally follow current best practices for implementing a large Python Django web platform like Open edX in a secure, cloud-hosted environment.
Besides reducing human error, there are other tangible improvements to managing your cloud infrastructure with Terraform as opposed to creating and managing your cloud infrastructure resources manually from the AWS console.
For example, all AWS resources are systematically tagged which in turn facilitates use of CloudWatch and improved consolidated logging and AWS billing expense reporting.

These scripts will create the following resources in your AWS account:

- **Compute Cluster**. uses `AWS EC2 <https://aws.amazon.com/ec2/>`_ behind a Classic Load Balancer.
- **Kubernetes**. Uses `AWS Elastic Kubernetes Service `_ to implement a Kubernetes cluster onto which all applications and scheduled jobs are deployed as pods.
- **MySQL**. uses `AWS RDS <https://aws.amazon.com/rds/>`_ for all MySQL data, accessible inside the vpc as mysql.courses.tutorlabs.cloud:3306. Instance size settings are located in the `environment configuration file <terraform/environments/prod/env.hcl>`_, and other common configuration settings `are located here <terraform/environments/prod/rds/terragrunt.hcl>`_. Passwords are stored in `Kubernetes Secrets <https://kubernetes.io/docs/concepts/configuration/secret/>`_ accessible from the EKS cluster.
- **MongoDB**. uses `AWS DocumentDB <https://aws.amazon.com/documentdb/>`_ for all MongoDB data, accessible insid the vpc as mongodb.master.courses.tutorlabs.cloud:27017 and mongodb.reader.courses.tutorlabs.cloud. Instance size settings are located in the `environment configuration file <terraform/environments/prod/env.hcl>`_, and other common configuration settings `are located here <terraform/modules/documentdb>`_. Passwords are stored in `Kubernetes Secrets <https://kubernetes.io/docs/concepts/configuration/secret/>`_ accessible from the EKS cluster.
- **Redis**. uses `AWS ElastiCache <https://aws.amazon.com/elasticache/>`_ for all Django application caches, accessible inside the vpc as cache.courses.tutorlabs.cloud. Instance size settings are located in the `environment configuration file <terraform/environments/prod/env.hcl>`_. This is necessary in order to make the Open edX application layer completely ephemeral. Most importantly, user's login session tokens are persisted in Redis and so these need to be accessible to all app containers from a single Redis cache. Common configuration settings `are located here <terraform/environments/prod/redis/terragrunt.hcl>`_. Passwords are stored in `Kubernetes Secrets <https://kubernetes.io/docs/concepts/configuration/secret/>`_ accessible from the EKS cluster.
- **Container Registry**. uses this `automated Github Actions workflow <.github/workflows/tutor_build_image.yml>`_ to build your `tutor Open edX container <https://docs.tutor.overhang.io/>`_ and then register it in `Amazon Elastic Container Registry (Amazon ECR) <https://aws.amazon.com/ecr/>`_. Uses this `automated Github Actions workflow <.github/workflows/tutor_deploy_prod.yml>`_ to deploy your container to `AWS Amazon Elastic Kubernetes Service (EKS) <https://aws.amazon.com/kubernetes/>`_. EKS worker instance size settings are located in the `environment configuration file <terraform/environments/prod/env.hcl>`_. Note that tutor provides out-of-the-box support for Kubernetes. Terraform leverages Elastic Kubernetes Service to create a Kubernetes cluster onto which all services are deployed. Common configuration settings `are located here <terraform/environments/prod/kubernetes/terragrunt.hcl>`_
- **User Data**. uses `AWS S3 <https://aws.amazon.com/s3/>`_ for storage of user data. This installation makes use of a `Tutor plugin to offload object storage <https://github.com/hastexo/tutor-contrib-s3>`_ from the Ubuntu file system to AWS S3. It creates a public read-only bucket named of the form prod-tutorlabs-global-storage, with write access provided to edxapp so that app-generated static content like user profile images, xblock-generated file content, application badges, e-commerce pdf receipts, instructor grades downloads and so on will be saved to this bucket. This is not only a necessary step for making your application layer ephemeral but it also facilitates the implementation of a CDN (which Terraform implements for you). Terraform additionally implements a completely separate, more secure S3 bucket for archiving your daily data backups of MySQL and MongoDB. Common configuration settings `are located here <terraform/environments/prod/s3/terragrunt.hcl>`_
- **CDN**. uses `AWS Cloudfront <https://aws.amazon.com/cloudfront/>`_ as a CDN, publicly acccessible as https://cdn.courses.tutorlabs.cloud. Terraform creates Cloudfront distributions for each of your enviornments. These are linked to the respective public-facing S3 Bucket for each environment, and the requisite SSL/TLS ACM-issued certificate is linked. Terraform also automatically creates all Route53 DNS records of form cdn.courses.tutorlabs.cloud. Common configuration settings `are located here <terraform/environments/prod/cloudfront/terragrunt.hcl>`_
- **Password & Secrets Management** uses `Kubernetes Secrets <https://kubernetes.io/docs/concepts/configuration/secret/>`_ in the EKS cluster. Open edX software relies on many passwords and keys, collectively referred to in this documentation simply as, "*secrets*". For all back services, including all Open edX applications, system account and root passwords are randomly and strongluy generated during automated deployment and then archived in EKS' secrets repository. This methodology facilitates routine updates to all of your passwords and other secrets, which is good practice these days. Common configuration settings `are located here <terraform/environments/prod/secrets/terragrunt.hcl>`_
- **SSL Certs**. Uses `AWS Certificate Manager <https://aws.amazon.com/certificate-manager/>`_ and LetsEncrypt. Terraform creates all SSL/TLS certificates. It uses a combination of AWS Certificate Manager (ACM) as well as LetsEncrypt. Additionally, the ACM certificates are stored in two locations: your aws-region as well as in us-east-1 (as is required by AWS CloudFront). Common configuration settings `are located here <terraform/modules/kubernetes/acm.tf>`_
- **DNS Management** uses `AWS Route53 <https://aws.amazon.com/route53/>`_ hosted zones for DNS management. Terraform expects to find your root domain already present in Route53 as a hosted zone. It will automatically create additional hosted zones, one per environment for production, dev, test and so on. It automatically adds NS records to your root domain hosted zone as necessary to link the zones together. Configuration data exists within several modules but the highest-level settings `are located here <terraform/modules/kubernetes/route53.tf>`_
- **System Access** uses `AWS Identity and Access Management (IAM) <https://aws.amazon.com/iam/>`_ to manage all system users and roles. Terraform will create several user accounts with custom roles, one or more per service.
- **Network Design**. uses `Amazon Virtual Private Cloud (Amazon VPC) <https://aws.amazon.com/vpc/>`_ based on the AWS account number provided in the `global configuration file <terraform/environments/global.hcl>`_ to take a top-down approach to compartmentalize all cloud resources and to customize the operating enviroment for your Open edX resources. Terraform will create a new virtual private cloud into which all resource will be provisioned. It creates a sensible arrangment of private and public subnets, network security settings and security groups. See additional VPC documentation  `here <terraform/environments/prod/vpc>`_
- **Proxy Access to Backend Services**. uses an `Amazon EC2 <https://aws.amazon.com/ec2/>`_ t2.micro Ubuntu instance publicly accessible via ssh as bastion.courses.tutorlabs.cloud:22 using the ssh key specified in the `global configuration file <terraform/environments/global.hcl>`_.  For security as well as performance reasons all backend services like MySQL, Mongo, Redis and the Kubernetes cluster are deployed into their own private subnets, meaning that none of these are publicly accessible. See additional Bastion documentation  `here <terraform/environments/prod/bastion>`_. Terraform creates a t2.micro EC2 instance to which you can connect via ssh. In turn you can connect to services like MySQL via the bastion. Common configuration settings `are located here <terraform/environments/prod/bastion/terragrunt.hcl>`_. Note that if you are cost conscious then you could alternatively use `AWS Cloud9 <https://aws.amazon.com/cloud9/>`_ to gain access to all backend services.

FAQ
---

Why Use Tutor?
~~~~~~~~~~~~~~
Tutor is the official Docker-based Open edX distribution, both for production and local development. The goal of Tutor is to make it easy to deploy, customize, upgrade and scale Open edX. Tutor is reliable, fast, extensible, and it is already used to deploy hundreds of Open edX platforms around the world.

- Runs on Docker
- 1-click installation and upgrades
- Comes with batteries included: theming, SCORM, HTTPS, web-based administration interface, mobile app, custom translations…
- Extensible architecture with plugins
- Works out of the box with Kubernetes
- Amazing premium plugins available in the Tutor Wizard Edition, including Cairn the next-generation analytics solution for Open edX.


Why Use Docker?
~~~~~~~~~~~~~~~
In a word, `Docker <https://docs.docker.com/get-started/>`_ is about "Packaging" your software in a way that simplifies how it is installed and managed so that you benefit from fast, consistent delivery of your applications.
A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings. Meanwhile, Docker is an open platform for developing, shipping, and running applications.

For context, any software which you traditionally relied on Linux package managers like apt, snap or yum can alternativley be installed and run as a Docker container.
Some examples of stuff which an Open edX platform depends: Nginx, MySQL, MongoDB, Redis, and the Open edX application software itself which Tutor bundles into a container using `Docker Compose <https://en.wikipedia.org/wiki/Infrastructure_as_code>`_.

Why Use Kubernetes?
~~~~~~~~~~~~~~~~~~
`Kubernetes <https://kubernetes.io/>`_ manages Docker containers in a deployment enviornment. It provides an easy way to scale your application, and is a superior, cost-effective alternative to you manually creating and maintaing individual virtual servers for each of your backend services.
It keeps code operational and speeds up the delivery process. Kubernetes enables automating a lot of resource management and provisioning tasks.

Your Open edX platform runs via multiple Docker containers: the LMS Django application , CMS Django application, one or more Celery-based worker nodes for each of these applications, nginx, Caddy, and any backend services that tutor manages like Nginx and SMTP for example.
Kubernetes creates EC2 instances and then decides where to place each of these containers based on various real-time resource-based factors.
This leads to your EC2 instances carrying optimal workloads, all the time.
Behind the scenes Kubernetes (EKS in our case) uses an EC2 Elastic Load Balancer (ELB) with an auto-scaling policy, both of which you can see from the AWS EC2 dashboard.


Why Use Terraform?
~~~~~~~~~~~~~~~~~~

`Terraform <https://www.terraform.io/>`_ allows you to manage the entire lifecycle of your AWS cloud infrastructure using `infrastructure as code (IAC) <https://en.wikipedia.org/wiki/Infrastructure_as_code>`_. That means declaring infrastructure resources in configuration files that are then used by Terraform to provision, adjust and tear down your AWS cloud infrastructure. There are tangential benefits to using IAC.

1. **Maintain all of your backend configuration data in a single location**. This allows you to take a more holistic, top-down approach to planning and managing your backend resources, which leads to more reliable service for your users.
2. **Leverage git**. This is a big deal! Managing your backend as IAC means you can track individual changes to your configuration over time. More importantly, it means you can reverse backend configuration changes that didn't go as planned.
3. **It's top-down and bottom-up**. You can start at the network design level and work your way up the stack, taking into consideration factors like security, performance and cost.
4. **More thorough**. You see every possible configuration setting for each cloud service. This in turns helps to you to consider all aspects of your configuration decisions.
5. **More secure**. IAC leads to recurring reviews of software versions and things getting patched when they should. It compels you to regularly think about the ages of your passwords. It makes it easier for you to understand how network concepts like subnets, private networks, CIDRs and port settings are being used across your entire backend.
6. **Saves money**. Taking a top-down approach with IAC will lead to you proactively and sensibly sizing your infrastructure, so that you don't waste money on infrastructure that you don't use.
7. **It's what the big guys use**. Your Open edX backend contains a lot of complexity, and it provides a view into the far-larger worlds of platforms like Google, Facebook, Tiktok and others. Quite simply, technology stacks have evolved to a point where we no longer have the ability to artesanlly manage any one part. That in a nutshell is why major internet platforms have been so quick to adopt tools like Terraform.

Why Use Terragrunt?
~~~~~~~~~~~~~~~~~~~

`Terragrunt <https://terragrunt.gruntwork.io/>`_ is a thin wrapper that provides extra tools for keeping your configurations DRY, working with multiple Terraform modules, and managing remote state. DRY means don't repeat yourself. That helped a lot with self-repeating modules we had to use in this architecture.
