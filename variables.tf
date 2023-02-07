variable "vpc_cidr_block" {
  type = string
  description = "CIDR range for the VPC"
}

variable "resource_tag_prefix" {
  type = string
  description = "Resource tag prefix for each resource."
  default = "project_1"
}

variable "vpc_endpoints" {
  type = list(string)
  description = "List of VPC endoint service name, eg) ssm, es2messages"
  default = ["ssm", "ec2messages", "ssmmessages"]
}