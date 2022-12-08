resource "google_compute_network" "vpc_network" {
  name                    = "akalaj-ha-vpn-vpc"
  project                 = "hc-03657a2ab8c84213a402eb28bbb"
  auto_create_subnetworks = false # Sets subnet-mode = custom
  routing_mode            = "GLOBAL"
}
