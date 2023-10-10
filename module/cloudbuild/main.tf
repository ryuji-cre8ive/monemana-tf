variable "project_id" {
  description = "gcp project id"
  type = string
  default = "monemana"
}

resource "google_cloudbuild_trigger" "cloudbuild_monemana" {
  location = "us-central1"
  name     = "cloudbuild-monemana"
  filename = "cloudbuild.yaml"

  github {
    owner = "ryuji-cre8ive"
    name  = "monemana"
    push {
      branch = "^main$"
    }
  }
   source_to_build {
    uri       = "https://github.com/ryuji-cre8ive/monemana"
    ref       = "refs/heads/main"
    repo_type = "GITHUB"
  }
}