
output "vpc_id" {
  value = aws_vpc.aws-learnings-test-vpc.id
}

output "private_subnet_ids" {
  value = aws_subnet.aws-learnings-test-private-subnet.*.id
}

output "public_subnet_ids" {
  value = aws_subnet.aws-learnings-test-public-subnet.*.id
}

output "private_route_table_ids" {
  value = aws_route_table.aws-learnings-test-priv-rtb.*.id
}

output "public_route_table_ids" {
  value = aws_route_table.aws-learnings-test-pub-rtb.*.id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.aws-learnings-test-natgw.*.id
}

output "nat_gateway_public_ips" {
  value = aws_nat_gateway.aws-learnings-test-natgw.*.public_ip
}

output "nat_gateway_private_ips" {
  value = aws_nat_gateway.aws-learnings-test-natgw.*.private_ip
}

output "database_subnet_group_id" {
  value = aws_db_subnet_group.aws-learnings-test-db-subnet-group.id
}

output "database_subnet_private_subnet" {
  value = aws_db_subnet_group.aws-learnings-test-db-subnet-group.subnet_ids
}

output "cidr_block" {
  value = aws_vpc.aws-learnings-test-vpc.cidr_block
}

output "bastion_subnet_id" {
  value = aws_subnet.aws-learnings-test-bastion-subnet.*.id
}

output "vpce_endpoint_s3" {
  value = aws_vpc_endpoint.aws-learnings-test-ecs-s3-endpoint
}