terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.6.0"
}

provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = jsondecode(base64decode(var.gcp_credentials))
}
