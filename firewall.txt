resource "google_compute_firewall" "bastion_firewall" {
  name    = "bastion-firewall"
  network = data.google_compute_network.my_network.name

  allow {
    protocol = "all"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080", "8200-8210", "8000", "514", "515", "3306", "443"]
  }
}
