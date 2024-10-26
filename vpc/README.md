<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.57.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_assumable_role_with_oidc"></a> [iam\_assumable\_role\_with\_oidc](#module\_iam\_assumable\_role\_with\_oidc) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | n/a |
| <a name="module_iam_assumable_role_with_oidc-test"></a> [iam\_assumable\_role\_with\_oidc-test](#module\_iam\_assumable\_role\_with\_oidc-test) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.aws-learnings-test-db-subnet-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_eip.aws-learnings-test-eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.aws-learnings-test-igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.aws-learnings-test-natgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.aws-learnings-test-priv-route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.aws-learnings-test-bastion-rtb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.aws-learnings-test-priv-rtb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.aws-learnings-test-priv-rtb-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.aws-learnings-test-pub-rtb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.aws-learnings-test-bastion-rtba](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.aws-learnings-test-db-rtba-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.aws-learnings-test-priv-rtba](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.aws-learnings-test-pub-rtba](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.aws-learnings-test-ecrapi-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.aws-learnings-test-ecrdkr-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.aws-learnings-test-ecs-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.aws-learnings-test-bastion-subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.aws-learnings-test-db-sub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.aws-learnings-test-private-subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.aws-learnings-test-public-subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.aws-learnings-test-vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.aws-learnings-test-ecrapi-ecr-s3-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.aws-learnings-test-ecrapi-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.aws-learnings-test-ecrdkr-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.aws-learnings-test-ecs-agent-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.aws-learnings-test-ecs-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.aws-learnings-test-ecs-s3-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.aws-learnings-test-ecs-telemetry-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.aws-learnings-test-interface-s3-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | The AZ for the private subnet | `list(any)` | <pre>[<br/>  "ap-southeast-1a",<br/>  "ap-southeast-1b",<br/>  "ap-southeast-1c"<br/>]</pre> | no |
| <a name="input_bastion_subnet"></a> [bastion\_subnet](#input\_bastion\_subnet) | The CIDR block for the bastion subnet | `string` | `"10.22.47.0/24"` | no |
| <a name="input_private_db_subnet_cidr"></a> [private\_db\_subnet\_cidr](#input\_private\_db\_subnet\_cidr) | The CIDR block for the private subnet | `list(any)` | <pre>[<br/>  "10.22.51.0/24",<br/>  "10.22.52.0/24",<br/>  "10.22.53.0/24"<br/>]</pre> | no |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | The CIDR block for the private subnet | `list(any)` | <pre>[<br/>  "10.22.0.0/24",<br/>  "10.22.16.0/24",<br/>  "10.22.32.0/24"<br/>]</pre> | no |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | The CIDR block for the public subnet | `list(any)` | <pre>[<br/>  "10.22.48.0/24",<br/>  "10.22.49.0/24",<br/>  "10.22.50.0/24"<br/>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The region for the VPC | `string` | `"ap-southeast-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_subnet_id"></a> [bastion\_subnet\_id](#output\_bastion\_subnet\_id) | n/a |
| <a name="output_cidr_block"></a> [cidr\_block](#output\_cidr\_block) | n/a |
| <a name="output_database_subnet_group_id"></a> [database\_subnet\_group\_id](#output\_database\_subnet\_group\_id) | n/a |
| <a name="output_database_subnet_private_subnet"></a> [database\_subnet\_private\_subnet](#output\_database\_subnet\_private\_subnet) | n/a |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | n/a |
| <a name="output_nat_gateway_private_ips"></a> [nat\_gateway\_private\_ips](#output\_nat\_gateway\_private\_ips) | n/a |
| <a name="output_nat_gateway_public_ips"></a> [nat\_gateway\_public\_ips](#output\_nat\_gateway\_public\_ips) | n/a |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_vpce_endpoint_s3"></a> [vpce\_endpoint\_s3](#output\_vpce\_endpoint\_s3) | n/a |
<!-- END_TF_DOCS -->