// Associate router to tunnels
resource "google_compute_router_interface" "interfaces" {
  provider   = google-beta
  for_each   = local.external_vpn_gateway_interfaces
  name       = "interface${each.key}-${google_compute_router.router.name}"
  router     = google_compute_router.router.name
  ip_range   = each.value.cgw_inside_address
  vpn_tunnel = google_compute_vpn_tunnel.tunnels[each.key].name
}
