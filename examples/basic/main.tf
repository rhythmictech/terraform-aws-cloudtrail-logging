
variable "region" { default = "us-east-1" }
variable "name" { default = "test" }

provider "aws" {
  region = var.region
}

module "tags" {
  source  = "rhythmictech/tags/terraform"
  version = "1.1.0"
  names   = ["account", var.name, "aws-test-me"]
  tags    = { delete_me : "please" }
}

module "cloudtrail_bucket" {
  source         = "rhythmictech/cloudtrail-bucket/aws"
  version        = "1.2.0"
  logging_bucket = module.s3logging_bucket.s3_bucket_name
  region         = var.region
  tags           = module.tags.tags
}

module "cloudtrail_logging" {
  source            = "../.."
  region            = var.region
  cloudtrail_bucket = module.cloudtrail_bucket.s3_bucket_name
  kms_key_id        = module.cloudtrail_bucket.kms_key_id
  log_group_name    = "${var.name}-test-lggrp"
  cloudtrail_name   = "${var.name}-test-cldtrl"
  tags              = module.tags.tags
}
