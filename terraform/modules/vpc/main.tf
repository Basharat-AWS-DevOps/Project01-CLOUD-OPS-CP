module "vpc" {
  source = "../../../modules/vpc"

  name        = var.project_name
  cidr_block = var.vpc_cidr
  az_count   = 2

  tags = {
    Project     = var.project_name
    Environment = "dev"
  }
}
