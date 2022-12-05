resource "hcp_hvn" "hcp_vault_hvn" {
  hvn_id         = "o-vault-hvn"
  cloud_provider = "aws"
  region         = "us-west-2"
  cidr_block     = "172.25.16.0/24"
}

resource "hcp_hvn_route" "route" {
  hvn_link         = hcp_hvn.hcp_vault_hvn.self_link
  hvn_route_id     = "hvn-to-tgw-attachment"
  destination_cidr = aws_vpc.main_vpc.cidr_block
  target_link      = hcp_aws_transit_gateway_attachment.aws_hcp_tgw_attachment.self_link
}
