output "private_subnet" {
  value = local.gke_private_subnet
}

output "gke_cluster_name" {
  value = local.gke_cluster_name
}

output "gcp_region" {
  value = var.gcp_region
}

output "gcp_project" {
  value =var.project
}
