resource "aws_ec2_transit_gateway" "vault_tgw" {
  amazon_side_asn                 = 64512
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  vpn_ecmp_support                = "enable"
  dns_support                     = "enable"
  tags = {
    Name     = "akalaj-Oanda-Demo-transit-gatway"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}
