variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique bucket name"
  type        = string
}

variable "location" {
  description = "Bucket location (e.g. US, EU, us-central1)"
  type        = string
  default     = "US"
}

variable "storage_class" {
  description = "Storage class (STANDARD, NEARLINE, COLDLINE, ARCHIVE)"
  type        = string
  default     = "STANDARD"
}

variable "versioning_enabled" {
  description = "Enable object versioning"
  type        = bool
  default     = false
}

variable "force_destroy" {
  description = "Allow bucket deletion even if it contains objects"
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules"
  type = list(object({
    action_type   = string
    age_days      = number
    storage_class = optional(string)
  }))
  default = []
}

variable "iam_bindings" {
  description = "List of IAM role/member bindings for the bucket"
  type = list(object({
    role   = string
    member = string
  }))
  default = []
}

variable "labels" {
  description = "Labels to apply to the bucket"
  type        = map(string)
  default     = {}
}