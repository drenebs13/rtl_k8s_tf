locals {
  gke_cluster_name   = "${var.project}-${var.env}-gke-standard-cluster"
  gke_private_subnet = "${var.project}-${var.env}-private-subnet"
}

module "gke_standard" {
  source = "./gke_standard"
  gcp_project_id = var.gcp_project_id
  gcp_region = var.gcp_region
  gcp_zone = var.gcp_zone
  project = var.project
  env = var.env
  master_ipv4_cidr_block = var.master_ipv4_cidr_block
  whitelist_cidr_blocks = var.whitelist_cidr_blocks
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  gke_cluster_name = local.gke_cluster_name
}
