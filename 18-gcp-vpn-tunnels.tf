resource "google_compute_vpn_tunnel" "tunnels" {
  provider                        = google-beta
  for_each                        = local.external_vpn_gateway_interfaces
  name                            = "tunnel${each.key}-${google_compute_router.router.name}"
  description                     = "Tunnel to AWS - HA VPN interface ${each.key} to AWS interface ${each.value.tunnel_address}"
  router                          = google_compute_router.router.self_link
  ike_version                     = 2
  shared_secret                   = each.value.shared_secret
  vpn_gateway                     = google_compute_ha_vpn_gateway.gateway.self_link
  vpn_gateway_interface           = each.value.vpn_gateway_interface
  peer_external_gateway           = google_compute_external_vpn_gateway.external_gateway.self_link
  peer_external_gateway_interface = each.key
}
