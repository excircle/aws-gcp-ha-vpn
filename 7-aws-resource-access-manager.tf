resource "aws_ram_resource_share" "vault_ram" {
  name                      = "hcp-vault-ram"
  allow_external_principals = true
}

resource "aws_ram_resource_association" "vault_ram_asc" {
  resource_share_arn = aws_ram_resource_share.vault_ram.arn
  resource_arn       = aws_ec2_transit_gateway.vault_tgw.arn
}
