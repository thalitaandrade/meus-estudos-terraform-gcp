terraform {
  backend "gcs" {
    bucket = "bucket-tfstate-grupo14-11soat-2"
    prefix = "terraform/state"
  }
}
