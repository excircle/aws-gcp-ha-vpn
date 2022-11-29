resource "hcp_hvn" "hcp_vault_hvn" {
  hvn_id         = "o-vault-hvn"
  cloud_provider = "aws"
  region         = "us-west-2"
  cidr_block     = "172.25.16.0/24"
}
