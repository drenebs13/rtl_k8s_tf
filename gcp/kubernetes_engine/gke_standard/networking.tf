##
## Network configuration
##

##
## Create a VPC along with its associated router
resource "google_compute_network" "vpc" {
  name                    = "${local.name_prefix}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_router" "vpc_router" {
  name    = "${local.name_prefix}-router"
  network = google_compute_network.vpc.self_link
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "${local.name_prefix}-private-subnet"
  ip_cidr_range = var.private_subnet_cidr_block
  network       = google_compute_network.vpc.id

  private_ip_google_access = true
}

##
## Create a NAT Gateway for outbound traffic from the private subnet
resource "google_compute_router_nat" "vpc_nat" {
  name = "${local.name_prefix}-nat"

  router  = google_compute_router.vpc_router.name

  nat_ip_allocate_option = "AUTO_ONLY"

  # Only use the NAT for the private subnet
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.private_subnet.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

##
## Create ingress/egress rules for the subnets
##

## Private - Allow ingress only from within the network
resource "google_compute_firewall" "private_subnet_ingress" {
  name    = "${local.name_prefix}-private-subnet-ingress"
  network = google_compute_network.vpc.self_link

  direction   = "INGRESS"
  description = "Allow traffic from the private subnet to the public subnet"

  allow {
    protocol = "all"
  }

  source_ranges = [
    google_compute_subnetwork.private_subnet.ip_cidr_range
  ]
  target_tags   = [local.private_subnet_tag]
}
