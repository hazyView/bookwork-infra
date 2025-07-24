variable "project" {
    default = "bookwork"
}

variable "api_image_tag" {
    default = "latest"
}

variable "frontend_image_tag" {
    default = "latest"
}

variable "domain_name" {
    description = "Bookwork domain name"
    type = string
    default = "bookwork.demo.com"
}