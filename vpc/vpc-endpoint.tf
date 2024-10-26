resource "aws_vpc_endpoint" "aws-learnings-test-ecrapi-endpoint" {
    vpc_id = aws_vpc.aws-learnings-test-vpc.id
    service_name = "com.amazonaws.${var.region}.ecr.api"
    vpc_endpoint_type = "Interface"
    private_dns_enabled = true
    security_group_ids = [aws_security_group.aws-learnings-test-ecrapi-sg.id]
    subnet_ids = aws_subnet.aws-learnings-test-private-subnet.*.id
    tags = {
        Name = "aws-learnings-test-ecrapi-endpoint"
    }

  depends_on = [ 
      aws_subnet.aws-learnings-test-private-subnet ]
policy=<<POLICY
{
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": "*",
			"Action": "*",
			"Resource": "*",
			"Condition": {
				"StringEquals": {
					"aws:PrincipalArn": [
						"arn:aws:iam::092744370500:role/AmazonEKS_EBS_CSI_DriverRole",
            "arn:aws:iam::092744370500:role/node-group-2-eks-node-group-20240630055633841600000005",
            "arn:aws:iam::092744370500:instance-profile/eks-a2c833df-aed6-a982-fbe8-e69553960588",
            "arn:aws:iam::092744370500:role/role-with-oidc"
					]
				},
				"StringNotEquals": {
					"aws:sourceVpc": "vpc-04ff4c8abd765d446"
				}
			}
		}
	]
}
POLICY
# }

# add policy using data source 

# policy = file("${path.module}/policy.json")

}

# create ecrdkr endpoint

resource "aws_vpc_endpoint" "aws-learnings-test-ecrdkr-endpoint" {
    vpc_id = aws_vpc.aws-learnings-test-vpc.id
    service_name = "com.amazonaws.${var.region}.ecr.dkr"
    vpc_endpoint_type = "Interface"
    private_dns_enabled = true
    security_group_ids = [aws_security_group.aws-learnings-test-ecrdkr-sg.id]
    subnet_ids = aws_subnet.aws-learnings-test-private-subnet.*.id
    tags = {
        Name = "aws-learnings-test-ecrdkr-endpoint"
    }
  depends_on = [ 
      aws_subnet.aws-learnings-test-private-subnet ]
policy=<<POLICY
{
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": "*",
			"Action": "*",
			"Resource": "*",
			"Condition": {
				"StringEquals": {
					"aws:PrincipalArn": [
						"arn:aws:iam::092744370500:role/AmazonEKS_EBS_CSI_DriverRole",
            "arn:aws:iam::092744370500:role/node-group-2-eks-node-group-20240630055633841600000005",
            "arn:aws:iam::092744370500:role/role-with-oidc"
					]
				},
				"StringNotEquals": {
					"aws:sourceVpc": "vpc-04ff4c8abd765d446"
				}
			}
		}
	]
}
POLICY

# policy = file("${path.module}/policy.json")

}

# # create ecrapi ecr s3 endpoint

resource "aws_vpc_endpoint" "aws-learnings-test-ecrapi-ecr-s3-endpoint" {
    vpc_id = aws_vpc.aws-learnings-test-vpc.id
    service_name = "com.amazonaws.${var.region}.ecr.api"
    vpc_endpoint_type = "Interface"
    private_dns_enabled = false
    security_group_ids = [aws_security_group.aws-learnings-test-ecrapi-sg.id]
    subnet_ids = aws_subnet.aws-learnings-test-private-subnet.*.id
    tags = {
        Name = "aws-learnings-test-ecrapi-ecr-s3-endpoint"
    }
  depends_on = [ 
      aws_subnet.aws-learnings-test-private-subnet ]
policy=<<POLICY
{
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": "*",
			"Action": "*",
			"Resource": "*",
			"Condition": {
				"StringEquals": {
					"aws:PrincipalArn": [
						"arn:aws:iam::092744370500:role/AmazonEKS_EBS_CSI_DriverRole",
            "arn:aws:iam::092744370500:role/node-group-2-eks-node-group-20240630055633841600000005",
            "arn:aws:iam::092744370500:role/role-with-oidc"
					]
				},
				"StringNotEquals": {
					"aws:sourceVpc": "vpc-04ff4c8abd765d446"
				}
			}
		}
	]
}
POLICY


}


# # create ecs s3 endpoint

resource "aws_vpc_endpoint" "aws-learnings-test-ecs-s3-endpoint" {
    vpc_id = aws_vpc.aws-learnings-test-vpc.id
    service_name = "com.amazonaws.${var.region}.s3"
    vpc_endpoint_type = "Gateway"
    private_dns_enabled = false
    # security_group_ids = [aws_security_group.aws-learnings-test-ecs-sg.id]
    # subnet_ids = aws_subnet.aws-learnings-test-private-subnet.*.id
    route_table_ids = flatten([
          aws_route_table.aws-learnings-test-priv-rtb[*].id,
          [aws_route_table.aws-learnings-test-pub-rtb.id]
  ])

    tags = {
        Name = "aws-learnings-test-ecs-s3-endpoint"
    }
  # create policy for s3 endpoint minimal access

policy=<<POLICY
{
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": "*",
			"Action": "*",
			"Resource": "*",
			"Condition": {
				"StringEquals": {
					"aws:PrincipalArn": [
						"arn:aws:iam::092744370500:role/AmazonEKS_EBS_CSI_DriverRole",
            "arn:aws:iam::092744370500:role/node-group-2-eks-node-group-20240630055633841600000005",
            "arn:aws:iam::092744370500:instance-profile/eks-a2c833df-aed6-a982-fbe8-e69553960588",
            "arn:aws:iam::092744370500:role/role-with-oidc"
					]
				},
				"StringNotEquals": {
					"aws:sourceVpc": "vpc-04ff4c8abd765d446"
				}
			}
		}
	]
}
POLICY

# policy = file("${path.module}/policy.json")
}


resource "aws_vpc_endpoint" "aws-learnings-test-interface-s3-endpoint" {
    vpc_id = aws_vpc.aws-learnings-test-vpc.id
    service_name = "com.amazonaws.${var.region}.s3"
    vpc_endpoint_type = "Interface"
    private_dns_enabled = true
    # security_group_ids = [aws_security_group.aws-learnings-test-ecs-sg.id]
    # subnet_ids = aws_subnet.aws-learnings-test-private-subnet.*.id
    route_table_ids = flatten([
          aws_route_table.aws-learnings-test-priv-rtb[*].id,
          [aws_route_table.aws-learnings-test-pub-rtb.id]
  ])

    tags = {
        Name = "aws-learnings-test-ecs-s3-endpoint-interface"
    }
  # create policy for s3 endpoint minimal access

policy=<<POLICY
{
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": "*",
			"Action": "*",
			"Resource": "*",
			"Condition": {
				"StringEquals": {
					"aws:PrincipalArn": [
						"arn:aws:iam::092744370500:role/AmazonEKS_EBS_CSI_DriverRole",
            "arn:aws:iam::092744370500:role/node-group-2-eks-node-group-20240630055633841600000005",
            "arn:aws:iam::092744370500:instance-profile/eks-a2c833df-aed6-a982-fbe8-e69553960588",
            "arn:aws:iam::092744370500:role/role-with-oidc"
					]
				},
				"StringNotEquals": {
					"aws:SourceVpc": "vpc-04ff4c8abd765d446"
				}
			}
		}
	]
}
POLICY
}

# create ecs-agent endpoint.

resource "aws_vpc_endpoint" "aws-learnings-test-ecs-agent-endpoint" {
    vpc_id = aws_vpc.aws-learnings-test-vpc.id
    service_name = "com.amazonaws.${var.region}.ecs-agent"
    vpc_endpoint_type = "Interface"
    private_dns_enabled = true
    security_group_ids = [aws_security_group.aws-learnings-test-ecs-sg.id]
    subnet_ids = aws_subnet.aws-learnings-test-private-subnet.*.id
    tags = {
        Name = "aws-learnings-test-ecs-agent-endpoint"
    }
}

# create ecs-telemetry endpoint
resource "aws_vpc_endpoint" "aws-learnings-test-ecs-telemetry-endpoint" {
    vpc_id = aws_vpc.aws-learnings-test-vpc.id
    service_name = "com.amazonaws.${var.region}.ecs-telemetry"
    vpc_endpoint_type = "Interface"
    private_dns_enabled = true
    security_group_ids = [aws_security_group.aws-learnings-test-ecs-sg.id]
    subnet_ids = aws_subnet.aws-learnings-test-private-subnet.*.id
    tags = {
        Name = "aws-learnings-test-ecs-telemetry-endpoint"
    }
}

# create ecs endpoint
resource "aws_vpc_endpoint" "aws-learnings-test-ecs-endpoint" {
    vpc_id = aws_vpc.aws-learnings-test-vpc.id
    service_name = "com.amazonaws.${var.region}.ecs"
    vpc_endpoint_type = "Interface"
    private_dns_enabled = true
    security_group_ids = [aws_security_group.aws-learnings-test-ecs-sg.id]
    subnet_ids = aws_subnet.aws-learnings-test-private-subnet.*.id
    tags = {
        Name = "aws-learnings-test-ecs-endpoint"
    }
}

# resource "aws_vpc_endpoint" "aws-learnings-test-vpce" {
#   vpc_id                    = aws_vpc.aws-learnings-test-vpc.id
#   subnet_ids                = data.terraform_remote_state.module_outputs.outputs.private_subnet_ids
#   vpc_endpoint_type         = "Interface"
#   service_name              = "com.amazonaws.${var.region}.ec2" # EC2 endpoint service name
#   private_dns_enabled       = false
#   tags = {
#         Name = "aws-learnings-test-ecs-s3-endpoint"
#     }
# policy=<<POLICY
# {
# 	"Statement": [
# 		{
# 			"Effect": "Allow",
# 			"Principal": "*",
# 			"Action": "*",
# 			"Resource": "*",
# 			"Condition": {
# 				"StringEquals": {
# 					"aws:PrincipalArn": [
# 						"arn:aws:iam::092744370500:role/AmazonEKS_EBS_CSI_DriverRole",
#             "arn:aws:iam::092744370500:role/node-group-2-eks-node-group-20240630055633841600000005",
#             "arn:aws:iam::092744370500:role/role-with-oidc"
# 					]
# 				},
# 				"StringNotEquals": {
# 					"aws:sourceVpc": "vpc-04ff4c8abd765d446"
# 				}
# 			}
# 		}
# 	]
# }
# POLICY

# # policy = file("${path.module}/policy.json")

#   depends_on = [ 
#       aws_subnet.aws-learnings-test-private-subnet ]
# }

# resource "aws_route" "aws-learnings-test-priv-route" {
#   count                  = length(var.private_subnet_cidr)
#   route_table_id         = element(aws_route_table.aws-learnings-test-priv-rtb.*.id, count.index)
#   destination_cidr_block = "0.0.0.0/0"
#   # nat_gateway_id         = element(aws_nat_gateway.aws-learnings-test-natgw.*.id, count.index)
#   # If you want to route traffic to the VPC endpoint instead of the NAT Gateway:
#   gateway_id             = element(aws_vpc_endpoint.aws-learnings-test-vpce.*.id, count.index)
# }

resource "aws_security_group" "aws-learnings-test-ecrdkr-sg" {
  name        = "aws-learnings-test-ecrdkr-sg"
  description = "Security group for POC ECR Docker"

  vpc_id = aws_vpc.aws-learnings-test-vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "aws-learnings-test-ecrapi-sg" {
  name        = "aws-learnings-test-ecrapi-sg"
  description = "Security group for POC ECR API"

  vpc_id = aws_vpc.aws-learnings-test-vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# aws-learnings-test-ecs-sg

resource "aws_security_group" "aws-learnings-test-ecs-sg" {
  name        = "aws-learnings-test-ecs-sg"
  description = "Security group for POC ECS"

  vpc_id = aws_vpc.aws-learnings-test-vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
