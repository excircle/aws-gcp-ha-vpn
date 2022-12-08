resource "google_compute_firewall" "bastion_firewall" {
  name    = "bastion-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "all"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080", "8200-8210", "8000", "514", "515", "3306", "443"]
  }
}
