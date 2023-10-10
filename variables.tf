variable "project_id" {
  description = "project id"
  type        = string
  default     = "monemana"
}

variable "region" {
  description = "The default region for resources"
  default     = "us-central1"
}

variable "github_branch" {
  default = "main"
}
variable "github_repo" {
  default = "monamana"
}
variable "github_owner" {
  default = "ryuji-cre8ive"
}