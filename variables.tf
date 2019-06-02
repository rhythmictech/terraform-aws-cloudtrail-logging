variable "region" {
  type = string
}

variable "cloudtrail_bucket" {
  description = "name of bucket for cloudtrail logs"
  type        = string
}

variable "kms_key_id" {
  description = "arn of the kms key to use for cloudtrail encryption"
  type        = string
}

