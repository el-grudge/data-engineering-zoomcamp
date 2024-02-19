variable "credentials" {
  description = "My Credentials"
  default     = "~/.gc/linen-source.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "linen-source-411501"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

# bigquery variables 
variable "bq_dataset_name" {
  description = "My BigQuery Dataset Trips Name"
  #Update the below to what you want your dataset to be called
  default     = "trips_data_all"
}