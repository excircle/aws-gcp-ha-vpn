// associates the route table with the vpc 
resource "aws_main_route_table_association" "main_vpc" {
  vpc_id         = aws_vpc.main_vpc.id
  route_table_id = aws_route_table.main_rt.id
}

// creates a route table that allows access to the HCP Vault cluster from the bastion subnet and configures internet egress access
resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block         = "172.25.16.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.vault_tgw.id
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
