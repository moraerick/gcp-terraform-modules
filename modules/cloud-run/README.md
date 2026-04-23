# Module: cloud-run

Deploys a containerized service to **Google Cloud Run** with configurable scaling, resource limits, environment variables, and IAM access control.

## Usage

```hcl
module "api_service" {
  source = "./modules/cloud-run"

  project_id   = "my-gcp-project"
  region       = "us-central1"
  service_name = "my-api"
  image        = "gcr.io/my-gcp-project/my-api:v1.0.0"

  min_instances = 0
  max_instances = 5
  cpu           = "1000m"
  memory        = "512Mi"

  env_vars = {
    ENV       = "production"
    LOG_LEVEL = "info"
  }

  service_account_email = "my-sa@my-gcp-project.iam.gserviceaccount.com"
  allow_unauthenticated = true
}

output "service_url" {
  value = module.api_service.service_url
}
```

## Variables

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `project_id` | GCP project ID | string | — | yes |
| `region` | GCP region | string | `us-central1` | no |
| `service_name` | Name of the Cloud Run service | string | — | yes |
| `image` | Container image URL | string | — | yes |
| `min_instances` | Min instances (0 = scale to zero) | number | `0` | no |
| `max_instances` | Max instances | number | `10` | no |
| `cpu` | CPU limit per instance | string | `1000m` | no |
| `memory` | Memory limit per instance | string | `512Mi` | no |
| `container_port` | Port the container listens on | number | `8080` | no |
| `env_vars` | Environment variables map | map(string) | `{}` | no |
| `service_account_email` | Service account to run the service | string | `null` | no |
| `allow_unauthenticated` | Allow public unauthenticated access | bool | `false` | no |

## Outputs

| Name | Description |
|---|---|
| `service_url` | Public URL of the Cloud Run service |
| `service_name` | Name of the service |
| `service_id` | Full resource ID |
| `latest_revision` | Name of the latest revision |

## Notes

- Set `min_instances = 0` to enable scale-to-zero (cost optimization)
- Set `allow_unauthenticated = true` only for public APIs
- The `image` field is excluded from lifecycle changes to allow external CI/CD to manage deployments without Terraform drift