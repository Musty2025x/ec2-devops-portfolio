# Terraform — EC2 environment

This module provisions one EC2 instance and a restrictive security group for the selected environment. Apply once with `environment = "staging"` and separately with `environment = "production"` using separate variable files/state keys or separate working directories.

## Remote state bootstrap

1. Create a unique S3 bucket in the same preferred region.
2. Enable bucket versioning, server-side encryption, and block all public access.
3. Restrict bucket access to the operator and deployment role.
4. Copy `backend.tf.example` to `backend.tf`, update bucket/region/key, then run `terraform init`.

Never commit `terraform.tfvars`, state files, access keys, or private keys.

## Before apply

- Use the current Amazon Linux 2023 AMI ID for the selected region.
- Restrict SSH to your own IP `/32`.
- Check AWS pricing and quotas.
- Review `terraform plan` before applying.
- This reference user-data installs Docker but does not configure the application by itself. Deploy Compose files and `.env` through your controlled bootstrap/deployment process.
