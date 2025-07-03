variable "vpc_id" {
  description = "VPC ID used for EC2 instances"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "sg_id" {
  description = "Security Group ID for EC2"
  type        = string
}
