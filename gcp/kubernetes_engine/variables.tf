##
## GCP Project variables
variable "gcp_project_id" {
  type        = string
  description = "GCP project ID in which all resources will be created"
}

variable "gcp_region" {
  type        = string
  description = "The default GCP region to deploy into (e.g. us-west2)"
  default     = "us-west2"
}

variable "gcp_zone" {
  type        = list
  description = "The default GCP zone to deploy into the specified region (e.g. us-west2-a)"
  default     = ["us-west2-a", "us-west2-b", "us-west2-c"]
}

##
## Project / environment variables
variable "project" {
  description = "The name of the project (used as a prefix for naming resources)"
}

variable "env" {
  description = "The name of the env (used as a prefix for naming resources)"
}

variable "whitelist_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks to whitelist"
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr_block" {
  type        = string
  description = "CIDR block for the private subnet"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "CIDR block for the kubernetes master"
}
