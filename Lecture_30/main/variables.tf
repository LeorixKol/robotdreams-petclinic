variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "AWS Key Pair name"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "terraform-advanced"
}