// Connects HCP to VPC's Transit Gateway
resource "hcp_aws_transit_gateway_attachment" "aws_hcp_tgw_attachment" {
  depends_on = [
    aws_ram_principal_association.hcp_ram,
    aws_ram_resource_association.vault_ram_asc,
  ]

  hvn_id                        = hcp_hvn.hcp_vault_hvn.hvn_id
  transit_gateway_attachment_id = "vpn-example-tgw-attach"
  transit_gateway_id            = aws_ec2_transit_gateway.aws_to_gcp_tgw.id
  resource_share_arn            = aws_ram_resource_share.vault_ram.arn
}
