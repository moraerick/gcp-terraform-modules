variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for the Cloud Run service"
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "Name of the Cloud Run service"
  type        = string
}

variable "image" {
  description = "Container image URL (e.g. gcr.io/project/image:tag)"
  type        = string
}

variable "min_instances" {
  description = "Minimum number of instances (0 = scale to zero)"
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 10
}

variable "cpu" {
  description = "CPU limit per instance"
  type        = string
  default     = "1000m"
}

variable "memory" {
  description = "Memory limit per instance"
  type        = string
  default     = "512Mi"
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 8080
}

variable "env_vars" {
  description = "Environment variables to inject into the container"
  type        = map(string)
  default     = {}
}

variable "service_account_email" {
  description = "Service account email to run the Cloud Run service"
  type        = string
  default     = null
}

variable "allow_unauthenticated" {
  description = "Whether to allow unauthenticated (public) access"
  type        = bool
  default     = false
}