variable "project_id" {
  description = "project id"
  type        = string
  default     = "monemana"
}

variable "region" {
  description = "The default region for resources"
  default     = "us-central1"
}


resource "google_cloud_run_service" "container" {
  name                       = var.project_id
  location                   = var.region
  autogenerate_revision_name = true

  template {
    spec {
      containers {
        resources {
          limits = {
            "memory" : "512Mi",
            "cpu" : "1"
          }
        }
        image = "us-central1-docker.pkg.dev/monemana/cloud-run-source-deploy/monemana/monemana:monemana-001"
        env {
          name  = "CLOUD_RUN_HTTPS_ENABLED"
          value = var.CLOUD_RUN_HTTPS_ENABLED
        }
        env {
          name  = "DATABASE_URL"
          value = var.DATABASE_URL
        }
        env {
          name  = "LINE_BOT_CHANNEL_SECRET"
          value = var.LINE_BOT_CHANNEL_SECRET
        }
        env {
          name  = "LINE_BOT_CHANNEL_TOKEN"
          value = var.LINE_BOT_CHANNEL_TOKEN
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  lifecycle {
    ignore_changes = [
      # gcloudからデプロイしたとき、以下のパラメータが入る。変更差分として判定したくないのでチェック対象から外す
      template[0].metadata[0].annotations["client.knative.dev/user-image"],
      template[0].metadata[0].annotations["run.googleapis.com/client-name"],
      template[0].metadata[0].annotations["run.googleapis.com/client-version"],
      # Clour Buildからビルド・デプロイしたとき、以下のパラメータが入る。変更差分として判定したくないのでチェック対象から外す
      template[0].metadata[0].labels,
      template[0].spec[0].containers["image"]
    ]
  }

}