
#Nodes use this service account to run VMs
#data "google_service_account" "my_sa" {
#  account_id = var.gke_cluster_service_account
#}

resource "google_container_node_pool" "gke_standard" {
  name       = "${local.name_prefix}-my-node-pool"
  location   = var.gcp_region
  cluster    = google_container_cluster.gke_standard.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.gke_nodes_machine_type

    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
