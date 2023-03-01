resource "google_cloud_run_service" "my_service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.container_image
      }
    }
  }
}
data "google_iam_policy" "admin" {
  binding {
    role = "roles/run.invoker"
    members = var.invoker_list
  }
}
resource "google_cloud_run_service_iam_policy" "my_service_invoker" {
  location    = google_cloud_run_service.my_service.location
  project     = google_cloud_run_service.my_service.project
  service     = google_cloud_run_service.my_service.name
  policy_data = data.google_iam_policy.admin.policy_data
}