variable "key_api" {
  default = ""
}
variable "key_app" {
  default = ""
}
variable "projectname" {
  default = "my-labs-task"
}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-c"
}
variable "createway" {
  default = "terraform"
}
variable "machinetype" {
  default = "n1-standard-1"
}
variable "image" {
  default = "centos-cloud/centos-7"
}
variable "hdd-size" {
  default = "20"
}
variable "hdd-type" {
  default = "pd-ssd"
}
variable "network-name" {
  default = "datadog-vpv"
}
variable "datadog-sub-net-name" {
  default = "datadog-sub-net"
}
variable "datadog-sub-net-ip-range" {
  default = "10.109.1.0/24"
}
variable "web-port" {
  type    = list
  default = ["0-65535"]
}
