resource "google_compute_router" "router" {
  provider    = google-beta
  name        = "cr-to-aws-tgw-ha-vpn-${data.aws_region.current.name}-akalaj"
  region      = "us-east4"
  network     = google_compute_network.vpc_network.id
  description = "Google to AWS via Transit GW connection for AWS region ${data.aws_region.current.name}"
  bgp {
    asn               = 65534
    advertise_mode    = "CUSTOM"
    advertised_groups = ["all_subnets"]
  }
}
