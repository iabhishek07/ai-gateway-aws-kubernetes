output "state_bucket_name" {
  description = "S3 bucket for Terraform state."
  value       = aws_s3_bucket.terraform_state.bucket
}

output "aws_region" {
  description = "Region containing the Terraform state bucket."
  value       = var.aws_region
}
