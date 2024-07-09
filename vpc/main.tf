resource "aws_vpc" "aws-learnings-test-vpc" {
  cidr_block           = "10.22.0.0/16"
  instance_tenancy     = "default"
  assign_generated_ipv6_cidr_block = true

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "aws-learnings-test-vpc"
  }
}

resource "aws_internet_gateway" "aws-learnings-test-igw" {
  vpc_id     = aws_vpc.aws-learnings-test-vpc.id
  depends_on = [aws_vpc.aws-learnings-test-vpc]

  tags = {
    Name = "aws-learnings-test-igw"
  }
}

# create eip

resource "aws_eip" "aws-learnings-test-eip" {
  count      = 1
  vpc        = true
  depends_on = [aws_internet_gateway.aws-learnings-test-igw]

  tags = {
    Name = "aws-learnings-test-eip"
  }
}

resource "aws_nat_gateway" "aws-learnings-test-natgw" {
count         = 1
allocation_id = aws_eip.aws-learnings-test-eip[0].id
subnet_id     = aws_subnet.aws-learnings-test-public-subnet[0].id

  tags = {
    Name = "aws-learnings-test-natgw-0"
  }
}

resource "aws_subnet" "aws-learnings-test-public-subnet" {
  count             = length(var.public_subnet_cidr)
  vpc_id            = aws_vpc.aws-learnings-test-vpc.id
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  depends_on = [aws_internet_gateway.aws-learnings-test-igw]

  tags = {
    Name                                          = "aws-learnings-test-public-${count.index}",
    "kubernetes.io/cluster/test-cluster-da" = "enabled",
    "kubernetes.io/role/elb"                      = "1"
  }
}

# create bastion_subnet

resource "aws_subnet" "aws-learnings-test-bastion-subnet" {
  count             = 1
  vpc_id            = aws_vpc.aws-learnings-test-vpc.id
  cidr_block        = var.bastion_subnet
  availability_zone = element(var.availability_zones, count.index)
  depends_on = [aws_internet_gateway.aws-learnings-test-igw]

  tags = {
    Name = "aws-learnings-test-bastion"
  }
}

# create route table bastion

resource "aws_route_table" "aws-learnings-test-bastion-rtb" {
  vpc_id = aws_vpc.aws-learnings-test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-learnings-test-igw.id
  }
  tags = {
    Name = "aws-learnings-test-bastion-rtb"
  }
}

# create route table association bastion

resource "aws_route_table_association" "aws-learnings-test-bastion-rtba" {
  count          = 1
  subnet_id      = aws_subnet.aws-learnings-test-bastion-subnet[0].id
  route_table_id = aws_route_table.aws-learnings-test-bastion-rtb.id
}

# create private subnet

resource "aws_subnet" "aws-learnings-test-private-subnet" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.aws-learnings-test-vpc.id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  # ipv6_cidr_block = "${cidrsubnet(aws_vpc.aws-learnings-test-vpc.ipv6_cidr_block, 8, 4)}"
  availability_zone = element(var.availability_zones, count.index)
  # map_public_ip_on_launch = true
  depends_on = [aws_route_table.aws-learnings-test-priv-rtb]

  tags = {
    Name                                          = "aws-learnings-test-private-${count.index}",
    "kubernetes.io/cluster/test-cluster-da" = "enabled",
    "kubernetes.io/role/internal-elb"             = "1",
    "kubernetes.io/role/elb" = "1"
  }
}

# create aws subnet db

resource "aws_subnet" "aws-learnings-test-db-sub" {
  count             = length(var.private_db_subnet_cidr)
  vpc_id            = aws_vpc.aws-learnings-test-vpc.id
  cidr_block        = element(var.private_db_subnet_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  # depends_on = [aws_route.aws-learnings-test-priv-route]

  tags = {
    Name = "aws-learnings-test-db-${count.index}"
  }
}

# # create aws_route
resource "aws_route" "aws-learnings-test-priv-route" {
  count                  = length(var.private_subnet_cidr)
  route_table_id         = element(aws_route_table.aws-learnings-test-priv-rtb.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.aws-learnings-test-natgw.*.id, count.index)
  # nat_gateway_id = aws_nat_gateway.aws-learnings-test-natgw[0].id

}

# route to s3 endpoint

# resource "aws_route" "aws-learnings-test-priv-route-s3" {
#   count                  = length(var.private_subnet_cidr)
#   route_table_id         = element(aws_route_table.aws-learnings-test-priv-rtb.*.id, count.index)
#   destination_cidr_block = data.terraform_remote_state.module_outputs.outputs.vpc_endpoint_s3_cidr_block
#   vpc_endpoint_id        = data.terraform_remote_state.module_outputs.outputs.vpc_endpoint_s3_id
# }

# create routeable public subnet

resource "aws_route_table" "aws-learnings-test-pub-rtb" {
  vpc_id = aws_vpc.aws-learnings-test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-learnings-test-igw.id
  }
  tags = {
    Name = "aws-learnings-test-pub-rtb"
  }
}


# create route tables

resource "aws_route_table" "aws-learnings-test-priv-rtb" {
  count = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.aws-learnings-test-vpc.id

  tags = {
    Name = "aws-learnings-test-priv-rtb-${count.index}"
  }
}


resource "aws_route_table_association" "aws-learnings-test-pub-rtba" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.aws-learnings-test-public-subnet.*.id, count.index)
  route_table_id = aws_route_table.aws-learnings-test-pub-rtb.id
}

resource "aws_route_table" "aws-learnings-test-priv-rtb-1" {
  count = length(var.private_db_subnet_cidr)
  vpc_id = aws_vpc.aws-learnings-test-vpc.id

  tags = {
    Name = "aws-learnings-test-priv-rtb-1-${count.index}"
  }
}

# create route table association

resource "aws_route_table_association" "aws-learnings-test-priv-rtba" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.aws-learnings-test-private-subnet.*.id, count.index)
  route_table_id = element(aws_route_table.aws-learnings-test-priv-rtb.*.id, count.index)
}



# create aws subnet db route table association

# resource "aws_route_table_association" "aws-learnings-test-db-rtba" {
#   count          = length(var.private_db_subnet_cidr)
#   subnet_id      = element(aws_subnet.aws-learnings-test-db-sub.*.id, count.index)
#   route_table_id = element(aws_route_table.aws-learnings-test-priv-rtb.*.id, count.index)
# }

resource "aws_route_table_association" "aws-learnings-test-db-rtba-1" {
  count          = length(var.private_db_subnet_cidr)
  subnet_id      = element(aws_subnet.aws-learnings-test-db-sub.*.id, count.index)
  route_table_id = element(aws_route_table.aws-learnings-test-priv-rtb-1.*.id, count.index)
}

# create aws db subnet group

resource "aws_db_subnet_group" "aws-learnings-test-db-subnet-group" {
  name       = "aws-learnings-test-db-subnet-group"
  subnet_ids = aws_subnet.aws-learnings-test-db-sub.*.id
  tags = {
    Name = "aws-learnings-test-db-subnet-group"
  }
}

module "iam_assumable_role_with_oidc" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = "role-with-oidc"

  tags = {
    Role = "role-with-oidc"
  }

  provider_url = "oidc.eks.ap-southeast-1.amazonaws.com/id/EF128E7F2F04EBEAF481E9FA4B46BD93"

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
  number_of_role_policy_arns = 2
}

module "iam_assumable_role_with_oidc-test" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = "test-role-with-oidc"

  tags = {
    Role = "test-role-with-oidc"
  }

  provider_url = "oidc.eks.ap-southeast-1.amazonaws.com/id/CADC4752C6A842DE06CCA092E41B8690"

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
  number_of_role_policy_arns = 2
}

