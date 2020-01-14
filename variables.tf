variable "cloudtrail_bucket" {
  description = "Name of bucket for CloudTrail logs"
  type        = string
}

variable "kms_key_id" {
  description = "KMS key ARN to use for encrypting CloudTrail logs"
  type        = string
}

variable "region" {
  description = "Region that CloudWatch logging and the S3 bucket will live in"
  type        = string
}
