output "service_url" {
  description = "The public URL of the Cloud Run service"
  value       = google_cloud_run_v2_service.this.uri
}

output "service_name" {
  description = "The name of the Cloud Run service"
  value       = google_cloud_run_v2_service.this.name
}

output "service_id" {
  description = "The full resource ID of the Cloud Run service"
  value       = google_cloud_run_v2_service.this.id
}

output "latest_revision" {
  description = "The name of the latest revision"
  value       = google_cloud_run_v2_service.this.latest_ready_revision
}