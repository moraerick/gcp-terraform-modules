output "bucket_name" {
  description = "The name of the bucket"
  value       = google_storage_bucket.this.name
}

output "bucket_url" {
  description = "The gs:// URL of the bucket"
  value       = google_storage_bucket.this.url
}

output "self_link" {
  description = "The self link of the bucket"
  value       = google_storage_bucket.this.self_link
}