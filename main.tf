/**
 * ## Usage
 *
 * Creates a IAM role with no permissions for use as a EC2 instance role.
 *
 * ```hcl
 * module "instance_role" {
 *   source = "dod-iac/ec2-instance-role/aws"
 *
 *   name = format("app-%s-instance-role-%s", var.application, var.environment)
 *
 *   tags  = {
 *     Application = var.application
 *     Environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 * Creates an IAM role for a EC2 instance that can join a AWS Managed Microsoft AD.
 *
 * ```hcl
 * module "domain_instance_role" {
 *   source = "dod-iac/ec2-instance-role/aws"
 *
 *   allow_seamless_domain_join = true
 *   name = format("app-%s-domain-instance-role-%s", var.application, var.environment)
 *
 *   tags  = {
 *     Application = var.application
 *     Environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * For more information see https://docs.aws.amazon.com/directoryservice/latest/admin-guide/launching_instance.html.
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

data "aws_partition" "current" {}

#
# IAM
#

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "main" {
  name               = var.name
  assume_role_policy = length(var.assume_role_policy) > 0 ? var.assume_role_policy : data.aws_iam_policy_document.assume_role_policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "amazon_ssm_managed_instance_core" {
  count      = var.allow_seamless_domain_join ? 1 : 0
  role       = aws_iam_role.main.name
  policy_arn = format("arn:%s:iam::aws:policy/AmazonSSMManagedInstanceCore", data.aws_partition.current.partition)
}

resource "aws_iam_role_policy_attachment" "amazon_ssm_directory_service_access" {
  count      = var.allow_seamless_domain_join ? 1 : 0
  role       = aws_iam_role.main.name
  policy_arn = format("arn:%s:iam::aws:policy/AmazonSSMDirectoryServiceAccess", data.aws_partition.current.partition)
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_service_for_ec2_role" {
  count      = var.allow_ecs ? 1 : 0
  role       = aws_iam_role.main.name
  policy_arn = format("arn:%s:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role", data.aws_partition.current.partition)
}
