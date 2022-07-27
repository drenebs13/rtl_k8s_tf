resource "google_container_cluster" "gke_standard" {
  name     = var.gke_cluster_name
  location = var.gcp_region

  # The default node node pool is immediately delete in case of standard cluster.
  remove_default_node_pool = true
  initial_node_count       = 1

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    master_global_access_config {
      enabled = true
    }
  }

  #Enables the Node autoscaling based on
  #Memory utilization:
  # Create a new node: utilization above 85%
  # Delete a under under-utilize node: utilization bellow 40%
  # CPU:
  # Create a new node: If total core less than or equal to 20
  # Minimum Core present at any time is set to 4
  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "memory"
      maximum       = 85
      minimum       = 40
    }
    resource_limits {
      resource_type = "cpu"
      maximum       = 20
      minimum       = 2
    }
  }

  #All nodes will be deployed in these zones
  node_locations = var.gcp_zone

  #GKE uses these network configuration to schedule the nodes
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.private_subnet.name

  #Associate cluster to an project
  project = var.gcp_project_id

  # Tags related to cluster
  resource_labels = {
    project_id   = var.gcp_project_id,
    cluster_name = var.gke_cluster_name
  }

  default_max_pods_per_node   = 20
  enable_intranode_visibility = true
  logging_service             = "logging.googleapis.com/kubernetes"
  monitoring_service          = "monitoring.googleapis.com/kubernetes"

}
