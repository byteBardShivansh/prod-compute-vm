provider "google" {
  region = var.region
  zone   = var.zone
}
resource "google_compute_network" "network" {
  name = "vm-base-network"
}
resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    network = google_compute_network.network.self_link
    access_config {}
  }
  tags = ["demo", "ci-cd"]
}