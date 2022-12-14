// Transit => AWS VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "vault_tgw" {
  subnet_ids         = [aws_subnet.main_subnet.id]
  transit_gateway_id = aws_ec2_transit_gateway.vault_tgw.id
  vpc_id             = aws_vpc.main_vpc.id
  tags = {
    Name     = "akalaj-Oanda-Demo-TGW-Attach"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}

// Transit => HCP HVN
resource "aws_ram_principal_association" "hcp_ram" {
  resource_share_arn = aws_ram_resource_share.vault_ram.arn
  principal          = hcp_hvn.hcp_vault_hvn.provider_account_id
}

resource "hcp_aws_transit_gateway_attachment" "aws_hcp_tgw_attachment" {
  depends_on = [
    aws_ram_principal_association.hcp_ram,
    aws_ram_resource_association.vault_ram_asc,
  ]

  hvn_id                        = hcp_hvn.hcp_vault_hvn.hvn_id
  transit_gateway_attachment_id = "example-tgw-attachment"
  transit_gateway_id            = aws_ec2_transit_gateway.vault_tgw.id
  resource_share_arn            = aws_ram_resource_share.vault_ram.arn
}
