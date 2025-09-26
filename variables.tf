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

variable "vpc_name" {
  description = "Nome da vpc"
  default     = "vpc-fiap-prj"
}

variable "vpc_private_subnet" {
  description = "Nome da sub-rede privada"
  type        = string
}

variable "vpc_cidr_range" {
  description = "Faixa CIDR da sub-rede privada"
  type        = string
}

variable "nat_router_name" {
  description = "Nome do Cloud Router para NAT"
  type        = string
}

variable "nat_router_config_name" {
  description = "Nome da configuração NAT do Cloud Router"
  type        = string
}

variable "ssh_source_range" {
  description = "IP ou range de IPs que podem acessar SSH"
  type        = string
  default     = "0.0.0.0/0"
}
variable "gke_service_account" {
  description = "Service account do GKE"
  type        = string
}
variable "gcp_credentials" {
  description = "Arquivo de credenciais"
  type        = string
}
# variable "credentials_file" {
#   description = "Arquivo JSON da service account"
#   type        = string
# }
# variable "vpc_id" {
#   description = "ID da VPC para conexão privada"
#   type        = string
# }

# variable "authorized_ip" {
#   description = "IP autorizado para acessar o banco"
#   type        = string
# }
