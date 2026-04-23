# Module: cloud-storage

Provisions a **Google Cloud Storage** bucket with configurable versioning, lifecycle rules, and IAM bindings. Enforces uniform bucket-level access by default.

## Usage

```hcl
module "app_bucket" {
  source = "./modules/cloud-storage"

  project_id    = "my-gcp-project"
  bucket_name   = "my-gcp-project-app-data"
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
      member = "serviceAccount:my-sa@my-gcp-project.iam.gserviceaccount.com"
    }
  ]

  labels = {
    environment = "production"
    team        = "platform"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `project_id` | GCP project ID | string | — | yes |
| `bucket_name` | Globally unique bucket name | string | — | yes |
| `location` | Bucket location | string | `US` | no |
| `storage_class` | Storage class | string | `STANDARD` | no |
| `versioning_enabled` | Enable object versioning | bool | `false` | no |
| `force_destroy` | Allow deletion even if bucket has objects | bool | `false` | no |
| `lifecycle_rules` | List of lifecycle rules | list(object) | `[]` | no |
| `iam_bindings` | List of IAM role/member bindings | list(object) | `[]` | no |
| `labels` | Labels to apply to the bucket | map(string) | `{}` | no |

## Outputs

| Name | Description |
|---|---|
| `bucket_name` | The name of the bucket |
| `bucket_url` | The gs:// URL of the bucket |
| `self_link` | The self link of the bucket |

## Notes

- `uniform_bucket_level_access` is always enabled — object-level ACLs are not supported
- Set `force_destroy = true` only in non-production environments
- Use `NEARLINE` or `COLDLINE` storage class for infrequently accessed data to reduce costs