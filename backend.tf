terraform {
  backend "gcs" {
    bucket = "firefly-tfstate-backend"
    prefix = "gcp-vm"          # folder-like path inside the bucket
  }
}