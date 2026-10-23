# Copy into backend.tf after creating a dedicated private S3 bucket.
# Terraform backend blocks cannot use variables.
terraform {
  backend "s3" {
    bucket       = "team-c-s3-strorage-bucket-app"
    key          = "team-c/ec2/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
