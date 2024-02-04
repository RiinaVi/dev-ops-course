<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name                                                                                                 | Version |
|------------------------------------------------------------------------------------------------------|---------|
| <a name="provider_aws"></a> [aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) | 5.35.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                            | Description                                                                                                                                                                                                                                      |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [aws_dynamodb_table.dynamodb_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)                                                                  | Provides a DynamoDB table resource.                                                                                                                                                                                                              |
| [aws_s3_bucket.state_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                                                             | Provides a S3 bucket resource.                                                                                                                                                                                                                   |
| [aws_s3_bucket_server_side_encryption_configuration.bucket_encrypt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | Provides a S3 bucket server-side encryption configuration resource.                                                                                                                                                                              |
| [aws_s3_bucket_versioning.versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                                                         | Provides a resource for controlling versioning on an S3 bucket. Deleting this resource will either suspend versioning on the associated S3 bucket or simply remove the resource from Terraform state if the associated S3 bucket is unversioned. |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
