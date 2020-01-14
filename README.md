# terraform-aws-cloudtrail-logging
[![](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/workflows/check/badge.svg)](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/actions)

Configure CloudTrail logging to CloudWatch Logs and S3.

## Usage
```

module "cloudtrail-logging" {
  source            = "git::https://github.com/rhythmictech/terraform-cloudtrail-logging"
  region            = var.region
  cloudtrail_bucket = module.cloudtrail-bucket.bucket_name
  kms_key_id        = module.cloudtrail-bucket.kms_key_id
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cloudtrail\_bucket | Name of bucket for CloudTrail logs | string | n/a | yes |
| kms\_key\_id | KMS key ARN to use for encrypting CloudTrail logs | string | n/a | yes |
| region | Region that CloudWatch logging and the S3 bucket will live in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch\_loggroup\_arn | The arn of the CloudWatch log group |
| cloudwatch\_loggroup\_name | The name of the CloudWatch log group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Related Projects
* [CloudTrail Bucket module](https://github.com/rhythmictech/terraform-aws-cloudtrail-bucket)
