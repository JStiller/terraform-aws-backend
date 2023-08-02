variable "project" {
  description = "To which project should everything be assigned?"
  type        = string

  validation {
    condition     = length(var.project) >= 3 && length(var.project) <= 40
    error_message = "The project name must be at least 3 and at most 20 characters long."
  }
}

variable "environment" {
  description = "In which environment should the infrastructe be deployed?"
  type        = string
  default     = "production"

  validation {
    condition     = contains(["production", "stage", "development"], var.environment)
    error_message = "There are only the following environments available: production, stage and development. Default is production."
  }
}

variable "version" {
  description = "To which version is this related?"
  type        = string

  validation {
    condition     = length(var.version) == 40
    error_message = "The version is represented by the commit hash and is exactly 40 characters long."
  }
}

variable "aws_region" {
  description = "To which aws region should everything be deployed?"
  type        = string
  default     = "eu-central-1"
  sensitive   = true

  validation {
    condition     = startswith("eu") && length(var.aws_region) >= 3 && length(var.aws_region) <= 20
    error_message = "The aws region must be within europe and one of the following: Central, West, South or North."
  }
}