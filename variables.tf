variable "cloudtrail_bucket" {
  description = "Name of bucket for CloudTrail logs"
  type        = string
}

variable "cloudtrail_name" {
  default     = "cloudtrail-all"
  description = "Name for the CloudTrail"
  type        = string
}

variable "iam_path" {
  default     = "/"
  description = "Path under which to put the IAM role. Should begin and end with a '/'."
  type        = string
}

variable "kms_key_id" {
  description = "KMS key ARN to use for encrypting CloudTrail logs"
  type        = string
}

variable "lambda_functions" {
  default     = []
  description = "Lambda functions to log. Specify `[\"arn:aws:lambda\"]` for all, or `[ ]` for none."
  type        = list
}

variable "log_group_name" {
  default     = "cloudtrail2cwl"
  description = "Name for CloudTrail log group"
  type        = string
}

variable "region" {
  description = "Region that CloudWatch logging and the S3 bucket will live in"
  type        = string
}

variable "retention_in_days" {
  default     = 7
  description = "How long should CloudTrail logs be retained in CloudWatch (does not affect S3 storage). Set to -1 for indefinite storage."
  type        = number
}

variable "tags" {
  default     = {}
  description = "Mapping of any extra tags you want added to resources"
  type        = map(string)
}

variable "s3_object_level_buckets" {
  default     = []
  description = "ARNs of buckets for which to enable object level logging. Specify `[\"arn:aws:s3:::\"]` for all, or `[ ]` for none. If listing ARNs, make sure to end each one with a `/`."
  type        = list
}
