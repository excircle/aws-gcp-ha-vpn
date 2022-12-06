resource "google_compute_subnetwork" "public" {
  name          = "public"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-east4"
  project       = "hc-03657a2ab8c84213a402eb28bbb"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "private" {
  name          = "private"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-east4"
  project       = "hc-03657a2ab8c84213a402eb28bbb"
  network       = google_compute_network.vpc_network.id
}
