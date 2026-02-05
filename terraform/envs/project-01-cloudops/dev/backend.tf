terraform {
  backend "s3" {
    bucket  = "cloudops-terraform-state-027687809970"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true

    # AWS auth
    profile = "cloudops-admin"

    # Native S3 state locking (modern Terraform)
    use_lockfile = true
  }
}

