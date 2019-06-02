output "cloudwatch_loggroup_arn" {
  description = "The arn of the cloudwatch log group"
  value       = aws_cloudwatch_log_group.cwl_loggroup.arn
}

output "cloudwatch_loggroup_name" {
  description = "The name of the cloudwatch log group"
  value       = aws_cloudwatch_log_group.cwl_loggroup.name
}

