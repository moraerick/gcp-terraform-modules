resource "google_storage_bucket" "this" {
  name                        = var.bucket_name
  project                     = var.project_id
  location                    = var.location
  storage_class               = var.storage_class
  uniform_bucket_level_access = true
  force_destroy               = var.force_destroy

  versioning {
    enabled = var.versioning_enabled
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action_type
        storage_class = lookup(lifecycle_rule.value, "storage_class", null)
      }
      condition {
        age = lifecycle_rule.value.age_days
      }
    }
  }

  labels = var.labels
}

resource "google_storage_bucket_iam_member" "this" {
  for_each = { for binding in var.iam_bindings : "${binding.role}/${binding.member}" => binding }
  bucket   = google_storage_bucket.this.name
  role     = each.value.role
  member   = each.value.member
}