

resource "aws_default_route_table" "rt_table" {
  default_route_table_id = aws_vpc.main_vpc.default_route_table_id

  route {
    cidr_block         = "172.25.16.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.aws_to_gcp_tgw.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name     = "akalaj-Oanda-Demo-route-table"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}
