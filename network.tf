resource "google_compute_network" "fiap_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "fiap_vpc_private_subnet" {
  name                     = var.vpc_private_subnet
  ip_cidr_range            = var.vpc_cidr_range
  region                   = var.region
  network                  = google_compute_network.fiap_vpc.id
  private_ip_google_access = true
}

resource "google_compute_router" "fiap_nat_router" {
  name    = var.nat_router_name
  network = google_compute_network.fiap_vpc.id
  region  = var.region
}

resource "google_compute_router_nat" "fiap_nat_config" {
  name                               = var.nat_router_config_name
  router                             = google_compute_router.fiap_nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_service_networking_connection" "private_vpc_connection" {
  depends_on = [google_compute_global_address.private_ip_range]

  lifecycle {
    prevent_destroy = false
  }

  network                 = google_compute_network.fiap_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]
}

resource "google_compute_global_address" "private_ip_range" {
  depends_on    = [google_compute_network.fiap_vpc, google_compute_global_address.private_ip_range]
  name          = "cloud-sql-private-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.fiap_vpc.id
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_firewall" "fiap_firewall_allow_ssh" {
  name    = "allow-ssh-to-vm"
  network = google_compute_network.fiap_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.ssh_source_range]

  target_tags = ["fiap"]
  direction   = "INGRESS"
  priority    = 1000
  description = "Allow SSH from anywhere"
  disabled    = false
  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
resource "google_compute_firewall" "allow_sql_access_vm" {
  name    = "allow-sql-access-vm"
  network = google_compute_network.fiap_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }
  source_tags = ["fiap"] 
  direction   = "INGRESS"
  priority    = 1000
  description = "Allow VM to access Cloud SQL"
}

# resource "google_compute_firewall" "allow_sql_access_gke" {
#   name    = "allow-sql-access-gke"
#   network = google_compute_network.fiap_vpc.name

#   allow {
#     protocol = "tcp"
#     ports    = ["5432"]
#   }

#   source_service_accounts = ["${var.gke_service_account}@${var.project_id}.iam.gserviceaccount.com"]
#   direction   = "INGRESS"
#   priority    = 1000
#   description = "Allow GKE nodes to access Cloud SQL"
# }
