variable "aws_region" {
  description = "AWS region used for the Terraform state bucket."
  type        = string
  default     = "us-east-1"
}

variable "project_prefix" {
  description = "Short prefix used to name project resources."
  type        = string
  default     = "aigw"
}
