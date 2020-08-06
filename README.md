# terraform-aws-cloudtrail-logging

[![tflint](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![tfsec](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/workflows/tfsec/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amaster)
[![yamllint](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/workflows/yamllint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amaster)
[![misspell](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/workflows/misspell/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amaster)
[![pre-commit-check](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/workflows/pre-commit-check/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-cloudtrail-logging/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amaster)
<a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=twitter" alt="follow on Twitter"></a>


Configure CloudTrail logging to CloudWatch Logs and S3. When used with [CloudTrail Bucket module](https://github.com/rhythmictech/terraform-aws-cloudtrail-bucket), this properly configures CloudTrail logging with a KMS CMK as required by CIS.

Logs can easily be centralized to a central security logging account by creating a bucket in a single account and referencing the bucket and KMS key.

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
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudtrail\_bucket | Name of bucket for CloudTrail logs | `string` | n/a | yes |
| kms\_key\_id | KMS key ARN to use for encrypting CloudTrail logs | `string` | n/a | yes |
| region | Region that CloudWatch logging and the S3 bucket will live in | `string` | n/a | yes |
| cloudtrail\_name | Name for the CloudTrail | `string` | `"cloudtrail-all"` | no |
| iam\_path | Path under which to put the IAM role. Should begin and end with a '/'. | `string` | `"/"` | no |
| lambda\_functions | Lambda functions to log. Specify `["arn:aws:lambda"]` for all, or `[ ]` for none. | `list` | `[]` | no |
| log\_group\_name | Name for CloudTrail log group | `string` | `"cloudtrail2cwl"` | no |
| retention\_in\_days | How long should CloudTrail logs be retained in CloudWatch (does not affect S3 storage). Set to -1 for indefinite storage. | `number` | `7` | no |
| s3\_object\_level\_buckets | ARNs of buckets for which to enable object level logging. Specify `["arn:aws:s3:::"]` for all, or `[ ]` for none. If listing ARNs, make sure to end each one with a `/`. | `list` | `[]` | no |
| tags | Mapping of any extra tags you want added to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch\_loggroup\_arn | The arn of the CloudWatch log group |
| cloudwatch\_loggroup\_name | The name of the CloudWatch log group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Related Projects
* [CloudTrail Bucket module](https://github.com/rhythmictech/terraform-aws-cloudtrail-bucket)
