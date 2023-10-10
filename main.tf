terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.40.0"
    }
  }
  required_version = ">= 1.3"
}

provider "google" {
  credentials = file("~/Devspace/important/monemana-b3b232c807dd.json")
  project     = var.project_id
  region      = var.region
}

module "api" {
  source = "./module/api"
}

module "cloudbuild" {
  source     = "./module/cloudbuild"
  project_id = var.project_id
}

module "cloudrun" {
  source       = "./module/cloudrun"
}