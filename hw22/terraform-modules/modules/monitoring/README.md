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

| Name                                                                                                            | Description                        |
|-----------------------------------------------------------------------------------------------------------------|------------------------------------|
| [aws_instance.monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | Provides an EC2 instance resource. |

## Inputs

| Name                                                                               | Description          | Type     | Default | Required |
|------------------------------------------------------------------------------------|----------------------|----------|---------|:--------:|
| <a name="input_ami"></a> [ami](./variables.tf)                                     | AMI                  | `string` | n/a     |   yes    |
| <a name="input_instance_env"></a> [instance\_env](./variables.tf)                  | Instance Env         | `string` | n/a     |   yes    |
| <a name="input_instance_name"></a> [instance\_name](./variables.tf)                | Instance Name        | `string` | n/a     |   yes    |
| <a name="input_instance_role"></a> [instance\_role](./variables.tf)                | Instance Role        | `string` | n/a     |   yes    |
| <a name="input_instance_type"></a> [instance\_type](./variables.tf)                | Instance type        | `string` | n/a     |   yes    |
| <a name="input_security_groups_name"></a> [security\_groups\_name](./variables.tf) | Security Groups Name | `string` | n/a     |   yes    |
| <a name="input_subnet_id"></a> [subnet\_id](./variables.tf)                        | Subnet ID            | `string` | n/a     |   yes    |

## Outputs

| Name                                                                  | Description      |
|-----------------------------------------------------------------------|------------------|
| <a name="output_ec2_global_ips"></a> [ec2\_global\_ips](./outputs.tf) | Global IP of EC2 |
| <a name="output_instance_id"></a> [instance\_id](./outputs.tf)        | EC2 id           |
<!-- END_TF_DOCS -->
