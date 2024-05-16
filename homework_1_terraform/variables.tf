variable "credentials" {
  description = "My Credentials"
  default     = "./gcp-credentials.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}

variable "project" {
  description = "Project"
  default     = "operating-attic-421512"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default = "asia-southeast2"
}

variable "location" {
  description = "Project Location"
  default = "ASIA-SOUTHEAST2"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default = "zul_zoomcamp_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default = "terra-bucket-operating-attic-421512"
}