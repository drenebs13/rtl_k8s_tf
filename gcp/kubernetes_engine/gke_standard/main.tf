locals {
  name_prefix       = "${var.project}-${var.env}"
  public_subnet_tag = "public-subnet"
  private_subnet_tag = "private-subnet"
 }
