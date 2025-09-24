resource "google_sql_database_instance" "main" {
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
      ipv4_enabled = true
      authorized_networks {
        name  = "anyone"
        value = "0.0.0.0/0"
      }
    }
  }
  timeouts {
    create = "15m"
  }  
}

resource "google_sql_user" "default" {
  name     = var.db_user
  instance = google_sql_database_instance.main.name
  password = google_secret_manager_secret_version.db_password.secret_data
}
