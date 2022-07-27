gcp_project_id        = "new-terraform-k8s"
gcp_region            = "us-west2"
gcp_zone              = ["us-west2-a","us-west2-b"]
project               = "rlt-tf-k8s"
env                   = "test"

# VPC / network variables
master_ipv4_cidr_block = "10.100.128.0/28"
public_subnet_cidr_block = "10.50.0.0/18"
private_subnet_cidr_block = "10.50.64.0/18"
whitelist_cidr_blocks = [
    "0.0.0.0/0"
]

