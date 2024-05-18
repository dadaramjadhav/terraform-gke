terraform {
  required_version = ">= 0.12"
  backend "gcs" {
    bucket = "dmj8682"
    prefix  = "terraform/state/test"
  }
}

provider "google" {
  project = "upheld-beach-417514"
  region  = "us-central1"
}

provider "kubernetes" {
  //host  = google_container_cluster.default.endpoint
  host  = "https://${google_container_cluster.default.endpoint}"
  token = data.google_client_config.current.access_token
  client_certificate = base64decode(
    google_container_cluster.default.master_auth[0].client_certificate,
  )
  client_key = base64decode(google_container_cluster.default.master_auth[0].client_key)
  cluster_ca_certificate = base64decode(
    google_container_cluster.default.master_auth[0].cluster_ca_certificate,
  )
}
