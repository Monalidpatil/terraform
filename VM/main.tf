resource "google_service_account" "default" {
  account_id   = var.project_id
  display_name = "Custom SA for VM Instance"

}
resource "google_compute_instance" "vm" {
  count                     = var.instance_count
  name                      = "${var.project_id}-server-${count.index}"
  machine_type              = var.machine_type
  zone                      = var.zone
  allow_stopping_for_update = true
  tags                      = ["web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    subnetwork = var.subnet_link

    access_config {
      // Ephemeral public IP
    }
  }
  metadata_startup_script = file("install_space-invaders.sh")

}