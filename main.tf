#Terraform code to deploy a GKE Autopilot cluster

provider "google" {
  credentials = file("<YOUR_SERVICE_ACCOUNT_KEY_FILE>")
  project     = "<YOUR_PROJECT_ID>"
  region      = "<YOUR_REGION>"
}

resource "google_container_cluster" "autopilot_cluster" {
  name     = "autopilot-cluster"
  location = "<YOUR_REGION>"


  release_channel {
    channel = "regular"
  }

  node_pool {
    name = "default-pool"
    config {
      autopilot = true
    }
  }
}

output "kubeconfig" {
  value = google_container_cluster.autopilot_cluster.master_auth.0.client_certificate_config[0].client_certificate
}

output "cluster_name" {
  value = google_container_cluster.autopilot_cluster.name
}
