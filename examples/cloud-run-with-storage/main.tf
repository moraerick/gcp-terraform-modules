# Example: Deploy a containerized API to Cloud Run
# with a dedicated service account and a GCS bucket for storage

locals {
  project_id = "my-gcp-project"
  region     = "us-central1"
}

# Service account for the Cloud Run service
module "service_account" {
  source = "./modules/iam-service-account"

  project_id   = local.project_id
  account_id   = "my-api-sa"
  display_name = "My API Service Account"
  description  = "Service account for the my-api Cloud Run service"

  roles = [
    "roles/storage.objectViewer",
    "roles/bigquery.dataViewer",
    "roles/cloudtrace.agent",
  ]
}

# GCS bucket for application data
module "app_bucket" {
  source = "./modules/cloud-storage"

  project_id    = local.project_id
  bucket_name   = "${local.project_id}-app-data"
  location      = "US"
  storage_class = "STANDARD"

  versioning_enabled = true

  lifecycle_rules = [
    {
      action_type   = "SetStorageClass"
      storage_class = "NEARLINE"
      age_days      = 30
    },
    {
      action_type = "Delete"
      age_days    = 365
    }
  ]

  iam_bindings = [
    {
      role   = "roles/storage.objectViewer"
      member = "serviceAccount:${module.service_account.email}"
    }
  ]

  labels = {
    environment = "production"
    team        = "platform"
  }
}

# Cloud Run service
module "api_service" {
  source = "./modules/cloud-run"

  project_id   = local.project_id
  region       = local.region
  service_name = "my-api"
  image        = "gcr.io/${local.project_id}/my-api:latest"

  min_instances = 0
  max_instances = 10
  cpu           = "1000m"
  memory        = "512Mi"

  env_vars = {
    ENV       = "production"
    BUCKET    = module.app_bucket.bucket_name
    LOG_LEVEL = "info"
  }

  service_account_email = module.service_account.email
  allow_unauthenticated = true
}

output "api_url" {
  value = module.api_service.service_url
}

output "bucket_url" {
  value = module.app_bucket.bucket_url
}

output "service_account_email" {
  value = module.service_account.email
}