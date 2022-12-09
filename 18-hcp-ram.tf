// "Resource Access Manager" (RAM) which shares HVN Account ID & Transit GW ARN
resource "aws_ram_resource_share" "vault_ram" {
  name                      = "hcp-vault-ram"
  allow_external_principals = true
}


// Associates (Loads the RAM with =>) HVN Account ID
resource "aws_ram_principal_association" "hcp_ram" {
  resource_share_arn = aws_ram_resource_share.vault_ram.arn
  principal          = hcp_hvn.hcp_vault_hvn.provider_account_id
}

// Associates (Loads the RAM with =>) Transit GW ARN
resource "aws_ram_resource_association" "vault_ram_asc" {
  resource_share_arn = aws_ram_resource_share.vault_ram.arn
  resource_arn       = aws_ec2_transit_gateway.aws_to_gcp_tgw.arn
}
