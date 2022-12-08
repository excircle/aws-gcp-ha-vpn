data "google_compute_subnetwork" "my_subnetwork" {
  name   = "default"
  region = "us-west2"
}

data "google_compute_network" "my_network" {
  name = "default"
}


// COMMAND | RESOURCE | NICKNAME
resource "google_service_account" "gcp_bastion_svc" {
  account_id   = "akalaj-gcp-bastion-svc"
  display_name = "akalajBastionHost"
}


resource "google_compute_instance" "bastion_host" {
  name         = "gcp-bastion-host"
  machine_type = "e2-small"
  zone         = "us-east4-a"

  boot_disk {
    initialize_params {
      image = "debian-10-buster-v20220920"
    }
  }

  network_interface {
    access_config {}
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.public.self_link
  }

  metadata = {
    ssh-keys = "akalaj:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4F/Joc7Fp9yhENm8ywSw3Ik74APnlFrErQiEgfxQC2a1ngVx3Wcfd4U3UJDJ1dlbZE2uX4o+/R02nP+mqYRyrSfXPVI6EnIvniWk3SSz1/FQXo1x+ZvYUBUOWJmv3Em3Uf01xje96cg1CbNrTxwpXuYS0QCvtC2/GQgYW4Zvd5GN07Wp5IWB7J/x1fHI1Tk8JFtFq8SVec4YGXLuH2VsM7wRBSMZ99y/DYJC3k6Bzh1ZK/MVTbiguJJNmsifbpHFY9UzVlQgGB+bOBPGU3JIBaeYfo68zDAL3VbN8PigiaBINqttUgh6+Kq8/ww5hSSYqUPNHn1s8YAdfcr8xDNGpW4JYYDa/Rsuo2UXkQqZ7M4SGowMAKxj+c1DXjHefp+eT6FsvTXYRFDHmVF/Ahi+siYEJLXZa3PUZwZ6v2zc9UVPRi6QF86y5kBcL9OhqTAGNNWv5JORY5RIXvMmIh67R72M8y9ZfmMIMb85A9rKuVRKwGau8hDKlA330gNg1LjVt/aJWeMMIvcQaTpY6bbujzK6Xa4CFMbdoS+BQDVVapYa8BPC7gNOA5fTfqkaZRd11zN8VOGwgHDy0QO4T8Wv9VVSuv/65bQeR8qgf2310840+2fXzdb3dkq6eIVMz/pDMQPQgdi75tS1bhsVwmECOr+DjhzgpYUgWrfe2XJxw0w== adkalaj@gmail.com"
  }

  service_account {
    email  = google_service_account.gcp_bastion_svc.email
    scopes = ["cloud-platform"]
  }
}
