variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  description = "Região do GCP"
  default     = "us-central1"
}

variable "instance_name" {
  description = "Nome da instância do Postgres"
  default     = "pg-instance"
}

variable "database_name" {
  description = "Nome do banco"
  default     = "app_db"
}

variable "db_user" {
  description = "Usuário do banco"
  default     = "app_user"
}
variable "gcp_credentials" {
  description = "Credenciais do GCP em JSON"
  type        = string
  sensitive   = true
}
