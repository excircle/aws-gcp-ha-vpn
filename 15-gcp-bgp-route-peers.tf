resource "google_compute_router_peer" "router_peers" {
  provider        = google-beta
  for_each        = local.external_vpn_gateway_interfaces
  name            = "peer${each.key}-${google_compute_router.router.name}"
  router          = google_compute_router.router.name
  peer_ip_address = each.value.vgw_inside_address
  peer_asn        = each.value.asn
  interface       = google_compute_router_interface.interfaces[each.key].name
}
