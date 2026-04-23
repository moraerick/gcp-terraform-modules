resource "google_service_account" "this" {
  project      = var.project_id
  account_id   = var.account_id
  display_name = var.display_name
  description  = var.description
}

resource "google_project_iam_member" "this" {
  for_each = toset(var.roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.this.email}"
}

resource "google_service_account_key" "this" {
  count              = var.create_key ? 1 : 0
  service_account_id = google_service_account.this.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}