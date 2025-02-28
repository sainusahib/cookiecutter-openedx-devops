#------------------------------------------------------------------------------
# written by: Miguel Afonso
#             https://www.linkedin.com/in/mmafonso/
#
# date: Aug-2021
#
# usage: create an AWS S3 bucket to offload Open edX file storage.
#------------------------------------------------------------------------------

module "openedx_storage" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "{{ cookiecutter.terraform_aws_modules_s3 }}"

  bucket = var.resource_name_storage
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  attach_policy = true
  policy        = data.aws_iam_policy_document.bucket_policy.json

  versioning = {
    enabled = false
  }
}

module "openedx_backup" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "{{ cookiecutter.terraform_aws_modules_s3 }}"

  bucket = var.resource_name_backup
  acl    = "private"

  versioning = {
    enabled = true
  }
}

module "openedx_secrets" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "{{ cookiecutter.terraform_aws_modules_s3 }}"

  bucket = var.resource_name_secrets
  acl    = "private"

  block_public_acls   = true
  block_public_policy = true

}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    actions = [
      "s3:GetObject*",
      "s3:List*",
    ]
    principals {
      identifiers = ["*"]
      type        = "*"
    }
    resources = [
      "${module.openedx_storage.s3_bucket_arn}/*"
    ]
  }
}

# Generate an additional IAM user with read-only access to the bucket
resource "random_id" "id" {
  byte_length = 16
}

resource "aws_iam_user" "user" {
  name = "s3-openedx-user-${random_id.id.hex}"
  path = "/system/s3-bucket-user/"
}

data "aws_iam_policy_document" "user_policy" {
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      module.openedx_storage.s3_bucket_arn,
      module.openedx_backup.s3_bucket_arn
    ]
  }
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "${module.openedx_storage.s3_bucket_arn}/*",
      "${module.openedx_backup.s3_bucket_arn}/*"
    ]
  }
}

resource "aws_iam_access_key" "user" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_policy" "policy" {
  name   = "s3-bucket"
  policy = data.aws_iam_policy_document.user_policy.json
  user   = aws_iam_user.user.name
}
