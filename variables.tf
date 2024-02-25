variable "owner" {
  description = "Who is responsible for this ressource?"
  type        = string

  validation {
    condition     = length(var.owner) >= 1 && length(var.owner) <= 200
    error_message = "The owner name must be at least 1 and at most 200 characters long. E.g John Doe, Team Hulk"
  }
}

variable "project" {
  description = "To which project should everything be assigned?"
  type        = string

  validation {
    condition     = length(var.project) >= 3 && length(var.project) <= 40
    error_message = "The project name must be at least 3 and at most 40 characters long. E.g. Project 8"
  }
}

variable "application" {
  description = "To which application should everything be assigned?"
  type        = string

  validation {
    condition     = length(var.application) >= 3 && length(var.application) <= 40
    error_message = "The application name must be at least 3 and at most 40 characters long. E.g. E-Commerce, CRM"
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

variable "git_hash" {
  description = "To which git hash is this related?"
  type        = string

  validation {
    condition     = length(var.git_hash) == 40
    error_message = "The git hash is exactly 40 characters long."
  }
}

variable "aws_region" {
  description = "To which aws region should everything be deployed?"
  type        = string
  default     = "eu-central-1"
  sensitive   = true

  validation {
    condition     = contains(["eu-north-1", "eu-central-1", "eu-central-2", "eu-south-1", "eu-south-2", "eu-west-1", "eu-west-2", "eu-west-3"], var.aws_region)
    error_message = "The aws region must be within europe and one of the following: Central, West, South or North."
  }
}

variable "bucket_name" {
  description = "In which bucket should the state of the infrastructe stored?"
  type        = string

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 200
    error_message = "The bucket name must be at least 3 and at most 200 characters long."
  }
}

variable "dynomodb_table" {
  description = "In which dynomodb table should the state lock file of the infrastructure be stored?"
  type        = string

  validation {
    condition     = length(var.dynomodb_table) >= 3 && length(var.dynomodb_table) <= 200
    error_message = "The dynomodb table must be at least 3 and at most 200 characters long."
  }
}
