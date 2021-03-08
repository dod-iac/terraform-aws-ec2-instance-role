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

For more information see https://docs.aws.amazon.com/directoryservice/latest/admin-guide/launching_instance.html.

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 2.55.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.55.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |
| [aws_partition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_seamless\_domain\_join | Allow instance to seamlessly join to your AWS Managed Microsoft AD directory. | `bool` | `false` | no |
| assume\_role\_policy | The assume role policy for the AWS IAM role.  If blank, allows EC2 instances in the account to assume the role. | `string` | `""` | no |
| name | The name of the AWS IAM role. | `string` | n/a | yes |
| tags | Tags applied to the AWS IAM role. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) of the AWS IAM Role. |
| name | The name of the AWS IAM Role. |
