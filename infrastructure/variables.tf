variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "The availability zones to deploy to"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
