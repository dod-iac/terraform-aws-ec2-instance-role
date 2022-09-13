<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

Creates a IAM role with no permissions for use as a EC2 instance role.

```hcl
module "instance_role" {
  source = "dod-iac/ec2-instance-role/aws"

  name = format("app-%s-instance-role-%s", var.application, var.environment)

  tags  = {
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}
```
Creates an IAM role for a EC2 instance that can join a AWS Managed Microsoft AD.

```hcl
module "domain_instance_role" {
  source = "dod-iac/ec2-instance-role/aws"

  allow_seamless_domain_join = true
  name = format("app-%s-domain-instance-role-%s", var.application, var.environment)

  tags  = {
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}
```

For more information on joining AD domains see https://docs.aws.amazon.com/directoryservice/latest/admin-guide/launching_instance.html.

Creates an IAM role to allow EC2 instance to be managed by EC2 Image Builder.

```hcl
module "domain_instance_role" {
  source = "dod-iac/ec2-instance-role/aws"

  allow_image_builder = true
  name = format("app-%s-image-builder-%s", var.application, var.environment)

  tags  = {
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}
```

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0, < 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.amazon_ec2_container_service_for_ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_ssm_directory_service_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_ssm_managed_instance_core](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ec2_instance_profile_for_image_builder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ec2_instance_profile_for_image_builder_ecr_container_builds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_ecs"></a> [allow\_ecs](#input\_allow\_ecs) | Allow instance to create or join an ECS cluster. | `bool` | `false` | no |
| <a name="input_allow_image_builder"></a> [allow\_image\_builder](#input\_allow\_image\_builder) | Allow instance to be managed by EC2 Image Builder. | `bool` | `false` | no |
| <a name="input_allow_seamless_domain_join"></a> [allow\_seamless\_domain\_join](#input\_allow\_seamless\_domain\_join) | Allow instance to seamlessly join to your AWS Managed Microsoft AD directory. | `bool` | `false` | no |
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | The assume role policy for the AWS IAM role.  If blank, allows EC2 instances in the account to assume the role. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the AWS IAM role. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the AWS IAM role. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the AWS IAM Role. |
| <a name="output_name"></a> [name](#output\_name) | The name of the AWS IAM Role. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
