variable "environment" {
  description = "Environment name"
  type        = string
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
}

variable "ia_transition_days" {
  description = "Days after which to transition objects to Standard-IA storage"
  type        = number
  default     = 30
}

variable "glacier_transition_days" {
  description = "Days after which to transition objects to Glacier storage"
  type        = number
  default     = 60
}

variable "expiration_days" {
  description = "Days after which to expire objects"
  type        = number
  default     = 365
} 