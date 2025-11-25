terraform {
  backend "https" {
    address        = "https://firefly-tfstate-backend/state/gcp-vm"
    lock_address   = "https://firefly-tfstate-backend/lock/gcp-vm"
    unlock_address = "https://firefly-tfstate-backend/unlock/gcp-vm"
    lock_method    = "POST"
    unlock_method  = "POST"
  }
}