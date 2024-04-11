variable "user_uuid" {
  description = "User UUID"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "The value for user_uuid must be a valid UUID in the format: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx."
  }
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket. Must be a valid bucket name according to AWS naming rules."

  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name)) && !can(regex("\\.\\.|-\\.|-$", var.bucket_name))
    error_message = "The bucket name must be between 3 and 63 characters long, and can only contain lowercase letters, numbers, periods (.), and hyphens (-)."
  }
}