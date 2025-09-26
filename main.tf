resource "google_sql_database_instance" "main" {
  depends_on = [google_service_networking_connection.private_vpc_connection]
  name             = var.instance_name
  database_version = "POSTGRES_14"
  region           = var.region
  deletion_protection = false
  settings {
    tier = "db-g1-small"
    backup_configuration {
      enabled = true
    }
    ip_configuration {
      ipv4_enabled = false
    #   private_network = data.google_compute_network.vpc_existente.self_link      
      private_network  = google_compute_network.fiap_vpc.id
    }
  }
  timeouts {
    create = "15m"
  }  
}

resource "google_sql_database" "default" {
  name     = var.database_name
  instance = google_sql_database_instance.main.name
}


resource "google_sql_user" "default" {
  name     = var.db_user
  instance = google_sql_database_instance.main.name
  password = google_secret_manager_secret_version.db_password.secret_data
}
