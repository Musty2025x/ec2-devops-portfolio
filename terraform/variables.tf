variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}
variable "project_name" {
  type        = string
  default     = "team-c"
}
variable "environment" {
  type        = string
  description = "staging or production"
  validation {
    condition     = contains(["staging", "production"], var.environment)
    error_message = "environment must be staging or production."
  }
}
variable "instance_type" {
  type        = string
  description = "Choose a cost-appropriate instance type for your account/region."
  default     = "t3.micro"
}
variable "ami_id" {
  type        = string
  description = "Current Amazon Linux 2023 AMI ID for the selected region."
}
variable "key_name" {
  type        = string
  description = "Existing EC2 key pair name"
}
variable "allowed_ssh_cidr" {
  type        = string
  description = "CIDR block to allow SSH access to the EC2 instance"
}
