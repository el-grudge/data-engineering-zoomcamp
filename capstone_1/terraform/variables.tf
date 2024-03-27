variable "credentials" {
  description = "My Credentials"
  #default     = "~/.gc/linen-source.json" # parametrize this
  #default     = var.google_application_credentials_file_path != "" ? var.google_application_credentials_file_path : null
}

variable "google_application_credentials_file_path" {
  description = "Path to the Google Cloud credentials JSON file. If not provided, it falls back to GOOGLE_APPLICATION_CREDENTIALS environment variable."
  default     = ""
}

variable "project" {
  description = "Project"
  default     = "data-engineering-zoomcamp" # change this in final version to 'money-diaries'
}

variable "app_name" {
  type        = string
  description = "Application Name"
  default     = "mage-data-prep"
}

variable "container_cpu" {
  description = "Container cpu"
  default     = "2000m"
}

variable "container_memory" {
  description = "Container memory"
  default     = "2G"
}

variable "project_id" {
  type        = string
  description = "The name of the project"
  default     = "linen-source-411501" # parameterize this 
}

variable "region" {
  type        = string
  description = "The default compute region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "The default compute zone"
  default     = "us-central1-c"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "repository" {
  type        = string
  description = "The name of the Artifact Registry repository to be created"
  default     = "mage-data-prep"
}

variable "database_user" {
  type        = string
  description = "The username of the Postgres database."
  default     = "mageuser"
}

variable "database_password" {
  type        = string
  description = "The password of the Postgres database."
  sensitive   = true
}

variable "docker_image" {
  type        = string
  description = "The docker image to deploy to Cloud Run."
  default     = "mageai/mageai:latest"
}

variable "domain" {
  description = "Domain name to run the load balancer on. Used if `ssl` is `true`."
  type        = string
  default     = ""
}

variable "ssl" {
  description = "Run load balancer on HTTPS and provision managed certificate with provided `domain`."
  type        = bool
  default     = false
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset" # change to money_diaries
}

