variable "allow_ecs" {
  type        = bool
  description = "Allow instance to create or join an ECS cluster."
  default     = false
}

variable "allow_image_builder" {
  type        = bool
  description = "Allow instance to be managed by EC2 Image Builder."
  default     = false
}

variable "allow_seamless_domain_join" {
  type        = bool
  description = "Allow instance to seamlessly join to your AWS Managed Microsoft AD directory."
  default     = false
}

variable "assume_role_policy" {
  type        = string
  description = "The assume role policy for the AWS IAM role.  If blank, allows EC2 instances in the account to assume the role."
  default     = ""
}

variable "name" {
  type        = string
  description = "The name of the AWS IAM role."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the AWS IAM role."
  default     = {}
}
