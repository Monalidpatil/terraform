###Module main##
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone

}
module "vpc" {
  source = ".//VPC"
}

module "vm" {
  source = ".//VM"
}
