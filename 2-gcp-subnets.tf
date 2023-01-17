resource "google_compute_subnetwork" "private" {
  name          = "private"
  ip_cidr_range = "10.1.1.0/24"
  region        = "us-east4"
  project       = data.google_project.project.project_id
  network       = google_compute_network.vpc_network.id
}
