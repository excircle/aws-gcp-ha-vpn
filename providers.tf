terraform {
  required_version = "~>1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.51.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "3.80.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "3.80.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~>0.10.0"
    }
  }
}

provider "hcp" {}

provider "aws" {
  region = "us-west-2"
}
