output "email" {
  description = "The email of the service account"
  value       = google_service_account.this.email
}

output "name" {
  description = "The full name of the service account"
  value       = google_service_account.this.name
}

output "id" {
  description = "The unique ID of the service account"
  value       = google_service_account.this.unique_id
}

output "key" {
  description = "Base64-encoded JSON key (only if create_key = true)"
  value       = var.create_key ? google_service_account_key.this[0].private_key : null
  sensitive   = true
}