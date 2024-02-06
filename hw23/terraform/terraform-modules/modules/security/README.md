<!-- BEGIN_TF_DOCS -->
# Security Module

## Requirements

No requirements.

## Providers

| Name                                                                                                 | Version |
|------------------------------------------------------------------------------------------------------|---------|
| <a name="provider_aws"></a> [aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) | 5.35.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                | Description                         |
|---------------------------------------------------------------------------------------------------------------------|-------------------------------------|
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | Provides a security group resource. |

## Inputs

| Name                                                                | Description                         | Type           | Default | Required |
|---------------------------------------------------------------------|-------------------------------------|----------------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](./variables.tf)     | The CIDR blocks for inbound traffic | `string`       | n/a     |   yes    |
| <a name="input_ingress_ports"></a> [ingress\_ports](./variables.tf) | The list of ingress ports           | `list(number)` | n/a     |   yes    |
| <a name="input_name_sg"></a> [name\_sg](./variables.tf)             | Name of the security group          | `string`       | n/a     |   yes    |
| <a name="input_vpc_id"></a> [vpc\_id](./variables.tf)               | Id of the VPC                       | `string`       | n/a     |   yes    |

## Outputs

| Name                                               | Description       |
|----------------------------------------------------|-------------------|
| <a name="output_sg_id"></a> [sg\_id](./outputs.tf) | Security Group Id |
<!-- END_TF_DOCS -->
