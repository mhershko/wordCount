#Variables
variable "infrastructure_version" {
  default = "1"
}
variable "subnet_count" {
  description = "no of subnets"
  default = 2
}
variable "access_key" {
  default = ""
}
variable "secret_key" {
  default = ""
}
variable "region" {
  default = "eu-central-1"
}
variable "vpc_cidr" {
  description = "The CIDR Block for the SiteSeer VPC"
  default     = "10.0.0.0/16"
}

variable "rt_wide_route" {
  description = "Route in the SiteSeer Route Table"
  default     = "0.0.0.0/0"
}
variable "availability_zones" {
  description = "availability zone to create subnet"
  default = [
    "eu-central-1"
  ]
}
variable "flask_app_port" {
  description = "Port exposed by the flask application"
  default = 5000
}
variable "flask_app_image" {
  description = "image for words-count-app"
  default = "820983956723.dkr.ecr.eu-central-1.amazonaws.com/word-count-app:latest"
}
variable "flask_app" {
  description = "FLASK APP variable"
  default = "app"
}
variable "flask_app_home" {
  description = "APP HOME variable"
  default = "/app/"
}
