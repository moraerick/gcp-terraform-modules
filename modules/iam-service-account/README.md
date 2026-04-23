# Module: iam-service-account

Creates a **GCP Service Account** and assigns IAM roles following least-privilege principles. Optionally generates a JSON key for external authentication.

## Usage

```hcl
module "service_account" {
  source = "./modules/iam-service-account"

  project_id   = "my-gcp-project"
  account_id   = "my-api-sa"
  display_name = "My API Service Account"
  description  = "Service account for the my-api Cloud Run service"

  roles = [
    "roles/storage.objectViewer",
    "roles/bigquery.dataViewer",
    "roles/cloudtrace.agent",
  ]
}

output "service_account_email" {
  value = module.service_account.email
}
```

## Variables

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `project_id` | GCP project ID | string | — | yes |
| `account_id` | Service account ID | string | — | yes |
| `display_name` | Human-readable display name | string | `""` | no |
| `description` | Description of the service account | string | `""` | no |
| `roles` | List of IAM roles to assign | list(string) | `[]` | no |
| `create_key` | Whether to create a JSON key | bool | `false` | no |

## Outputs

| Name | Description |
|---|---|
| `email` | The email of the service account |
| `name` | The full name of the service account |
| `id` | The unique ID of the service account |
| `key` | Base64-encoded JSON key (only if `create_key = true`) |

## Notes

- Assign only the minimum roles required — avoid `roles/owner` or `roles/editor`
- Set `create_key = true` only when the service account needs to authenticate from outside GCP (e.g. CI/CD pipelines). For workloads running on GCP, use Workload Identity instead
- The `key` output is marked `sensitive = true` — store it in Secret Manager or a vault, never in version control