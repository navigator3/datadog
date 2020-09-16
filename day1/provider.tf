provider "google" {
  #credentials = "${file("/home/terraform-admin.json")}"
  project = "${var.projectname}"
  region  = "${var.region}"
}
provider "datadog" {
  api_key = "${var.key_api}"
  app_key = "${var.key_app}"
}
