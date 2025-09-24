terraform {
  backend "gcs" {
    bucket  = "bucket-tfstate-grupo14-11soat"
    prefix  = "terraform/state"
  }
}
