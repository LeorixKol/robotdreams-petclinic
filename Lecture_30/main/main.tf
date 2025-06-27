terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Get availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  common_tags = {
    Project   = var.project_name
    ManagedBy = "terraform"
  }
}

# VPC Module
module "vpc" {
  source   = "../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "${var.project_name}-vpc"
  tags     = local.common_tags
}

# Subnet Module
module "subnet" {
  source               = "../modules/subnet"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  availability_zone   = data.aws_availability_zones.available.names[0]
  tags                = local.common_tags
}

# EC2 Module
module "ec2" {
  source            = "../modules/ec2"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.subnet.public_subnet_id
  private_subnet_id = module.subnet.private_subnet_id
  key_name         = var.key_name
  tags             = local.common_tags
}

# S3 Imported Module
resource "aws_s3_bucket" "manually_created_bucket" {
  bucket = "xxx-manually-bucket"

  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = true

      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = false
  }
}

# VPC Imported Module
resource "aws_security_group" "manually_created_sg" {
  name        = "xxx-manually-sg"
  description = "Manually created SG"
  vpc_id      = "vpc-0409da41c74eb922b"

  egress {
    description = "Webmin for all IPv4"
    from_port   = 10000
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}