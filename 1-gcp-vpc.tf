resource "google_compute_network" "vpc_network" {
  name                    = "akalaj-ha-vpn-vpc"
  project                 = data.google_project.project.project_id
  auto_create_subnetworks = false # Sets subnet-mode = custom
  routing_mode            = "GLOBAL"
}
