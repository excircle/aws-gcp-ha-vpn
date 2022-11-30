resource "google_compute_ha_vpn_gateway" "gateway" {
  provider = google-beta
  name     = "ha-vpn-gw-to-aws-${data.aws_region.current.name}-akalaj"
  project  = data.google_project.project.project_id
  network  = "default"
}
