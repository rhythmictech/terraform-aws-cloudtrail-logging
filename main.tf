data "aws_caller_identity" "current" {
}

data "aws_partition" "current" {
}

locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition

  # Need a list to work with for_each, but don't actually want to for_each
  log_s3     = length(var.s3_object_level_buckets) > 0 ? [true] : []
  log_lambda = length(var.lambda_functions) > 0 ? [true] : []
}

resource "aws_cloudtrail" "trail" {
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_cloudwatch_events_role.arn
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cwl_loggroup.arn}:*"
  enable_log_file_validation = "true"
  enable_logging             = "true"
  is_multi_region_trail      = "true"
  kms_key_id                 = var.kms_key_id
  name                       = var.cloudtrail_name
  s3_bucket_name             = var.cloudtrail_bucket
  tags                       = var.tags

  # S3 object logging:
  event_selector {
    read_write_type           = "All"
    include_management_events = true

    dynamic "data_resource" {
      for_each = local.log_s3
      content {
        type   = "AWS::S3::Object"
        values = var.s3_object_level_buckets
      }
    }

    dynamic "data_resource" {
      for_each = local.log_lambda
      content {
        type   = "AWS::Lambda::Function"
        values = var.lambda_functions
      }
    }
  }
}

resource "aws_iam_role" "cloudtrail_cloudwatch_events_role" {
  name_prefix        = "cloudtrail_events_role"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.cwl_assume_policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "cwl_policy" {
  name_prefix = "cloudtrail_cloudwatch_events_policy"
  role        = aws_iam_role.cloudtrail_cloudwatch_events_role.id
  policy      = data.aws_iam_policy_document.cwl_policy.json
}

data "aws_iam_policy_document" "cwl_assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cwl_policy" {
  statement {
    effect  = "Allow"
    actions = ["logs:CreateLogStream"]

    resources = [
      "arn:${local.partition}:logs:${var.region}:${local.account_id}:log-group:${aws_cloudwatch_log_group.cwl_loggroup.name}:log-stream:*",
    ]
  }

  statement {
    effect  = "Allow"
    actions = ["logs:PutLogEvents"]

    resources = [
      "arn:${local.partition}:logs:${var.region}:${local.account_id}:log-group:${aws_cloudwatch_log_group.cwl_loggroup.name}:log-stream:*",
    ]
  }
}

resource "aws_cloudwatch_log_group" "cwl_loggroup" {
  name              = var.log_group_name
  kms_key_id        = var.kms_key_id
  retention_in_days = var.retention_in_days == -1 ? null : var.retention_in_days
  tags              = var.tags
}

resource "aws_cloudwatch_log_stream" "cwl_stream" {
  name           = local.account_id
  log_group_name = aws_cloudwatch_log_group.cwl_loggroup.name
}
