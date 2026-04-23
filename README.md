# GCP Terraform Modules

A collection of reusable Terraform modules for Google Cloud Platform (GCP), designed for production-grade infrastructure provisioning. Each module follows Terraform best practices and is independently deployable.

Built and maintained by **Erick Mora** — DevOps Engineer with hands-on GCP experience at enterprise scale (Equifax).

---

## Modules

| Module | Description |
|---|---|
| [cloud-run](./modules/cloud-run) | Deploy containerized services to Cloud Run with IAM and traffic control |
| [cloud-storage](./modules/cloud-storage) | Provision GCS buckets with versioning, lifecycle, and IAM bindings |
| [bigquery](./modules/bigquery) | Create BigQuery datasets and tables with schema and access control |
| [compute-instance](./modules/compute-instance) | Provision Compute Engine VMs with startup scripts and firewall rules |
| [iam-service-account](./modules/iam-service-account) | Create and bind GCP service accounts with least-privilege roles |
| [vpc](./modules/vpc) | Create VPC networks with subnets, firewall rules, and NAT gateway |

---

## Usage

Each module can be used independently. Example:

```hcl
module "cloud_run" {
  source  = "./modules/cloud-run"

  project_id    = "my-gcp-project"
  region        = "us-central1"
  service_name  = "my-api"
  image         = "gcr.io/my-gcp-project/my-api:latest"
  min_instances = 0
  max_instances = 10
}
```

See each module's README for full usage and variable reference.

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.3
- [gcloud CLI](https://cloud.google.com/sdk/docs/install) configured
- A GCP project with billing enabled
- A service account with appropriate permissions

## Authentication

```bash
gcloud auth application-default login
# or use a service account key
export GOOGLE_APPLICATION_CREDENTIALS="path/to/key.json"
```

---

## Stack

- **Cloud:** Google Cloud Platform
- **IaC:** Terraform
- **Services:** Cloud Run · Cloud Storage · BigQuery · Compute Engine · IAM · VPC

---

## Author

**Erick Mora** — DevOps Engineer  
[GitHub](https://github.com/moraerick) · [Upwork](https://www.upwork.com/freelancers/~0149e55b219704f472)
