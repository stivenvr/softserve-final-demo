variable "vpc" {
    default = "vpc-069d5bd758500ab21"
    type = string
    description = "this is the value "
}

variable "region" {
    default = "us-east-1"
    type = string
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(any)
  default     = ["80", "443", "22", "5555"]
}