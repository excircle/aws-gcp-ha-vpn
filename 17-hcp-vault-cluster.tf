resource "hcp_vault_cluster" "vault_cluster" {
  hvn_id          = hcp_hvn.hcp_vault_hvn.hvn_id
  cluster_id      = "o-vault-cluster"
  tier            = "dev"
  public_endpoint = false
}
