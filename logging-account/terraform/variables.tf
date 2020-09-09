variable "bucket" {
  description = "Bucket name."
}

variable "force_destroy" {
  default     = false
  description = "Allow remove bucket with its content."
}

variable "cloudtrail_path" {
  description = "Prefix for CloudTrail logs."
  default     = "cloudtrail/"
}

variable "config_path" {
  description = "Prefix for AWS Config logs."
  default     = "config/"
}
