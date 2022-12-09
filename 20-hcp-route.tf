resource "hcp_hvn_route" "route" {
  hvn_link         = hcp_hvn.hcp_vault_hvn.self_link
  hvn_route_id     = "hvn-to-tgw-route"
  destination_cidr = aws_vpc.main_vpc.cidr_block
  target_link      = hcp_aws_transit_gateway_attachment.aws_hcp_tgw_attachment.self_link
}

resource "hcp_hvn_route" "gcp_to_hnv_route" {
  hvn_link         = hcp_hvn.hcp_vault_hvn.self_link
  hvn_route_id     = "hnv-to-gcp-route"
  destination_cidr = google_compute_subnetwork.public.ip_cidr_range
  target_link      = hcp_aws_transit_gateway_attachment.aws_hcp_tgw_attachment.self_link
}
