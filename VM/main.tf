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


  user_data = <<-EOF
      #!/bin/sh
      sudo apt-get update
      sudo apt install -y apache2
      sudo systemctl status apache2
      sudo systemctl start apache2
      sudo chown -R $USER:$USER /var/www/html
      sudo echo "<html><body><h1>Hello this is module-1 at instance id `curl http://169.254.169.254/latest/meta-data/instance-id` </h1></body></html>" > /var/www/html/index.html
      EOF

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
  #   metadata_startup_script = file("install_space-invaders.sh")
}

