variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "account_id" {
  description = "Service account ID (e.g. my-service-account)"
  type        = string
}

variable "display_name" {
  description = "Human-readable display name"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the service account"
  type        = string
  default     = ""
}

variable "roles" {
  description = "List of IAM roles to assign to the service account"
  type        = list(string)
  default     = []
}

variable "create_key" {
  description = "Whether to create a JSON key for the service account"
  type        = bool
  default     = false
}