<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) |  5.35.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                       | Description                                                                                                                                                 |
|--------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)                                             | Provides an Elastic IP resource.                                                                                                                            |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)                   | Provides a resource to create a VPC Internet Gateway.                                                                                                       |
| [aws_nat_gateway.natgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)                           | Provides a resource to create a VPC NAT Gateway.                                                                                                            |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                         | Provides a resource to create a private VPC routing table.                                                                                                  |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                          | Provides a resource to create a public VPC routing table.                                                                                                   |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | Provides a resource to create a private association between a route table and a subnet or a route table and an internet gateway or virtual private gateway. |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)  | Provides a resource to create a public association between a route table and a subnet or a route table and an internet gateway or virtual private gateway.  |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                   | Provides a private VPC subnet resource.                                                                                                                     |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                    | Provides a public VPC subnet resource.                                                                                                                      |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)                                            | Provides a main VPC resource.                                                                                                                               |

## Inputs

| Name                                                                             | Description | Type | Default | Required |
|----------------------------------------------------------------------------------|-------------|------|---------|:--------:|
| <a name="input_av_zone"></a> [av\_zone](./variables.tf)                          | List of availability zones in the region | `list(string)` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](./variables.tf) | List of private subnet CIDR blocks | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](./variables.tf)    | List of public subnet CIDR blocks | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](./variables.tf)                      | VPC CIDR block | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](./variables.tf)                      | Name of VPC | `string` | n/a | yes |

## Outputs

| Name                                                                                       | Description         |
|--------------------------------------------------------------------------------------------|---------------------|
| <a name="output_igw_id"></a> [igw\_id](./outputs.tf)                              | Internet Gateway Id |
| <a name="output_nat_gw_id"></a> [nat\_gw\_id](./outputs.tf)                        | NAT Gateway Id      |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](./outputs.tf) | Private Subnet Ids  |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](./outputs.tf) | Public Subnet Ids   |
| <a name="output_vpc_id"></a> [vpc\_id](./outputs.tf)                                   | VPC Id              |
<!-- END_TF_DOCS -->
