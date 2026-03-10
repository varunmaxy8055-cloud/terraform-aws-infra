variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1" {
  description = "Public subnet AZ1"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2" {
  description = "Public subnet AZ2"
  default     = "10.0.2.0/24"
}

variable "private_subnet_1" {
  description = "Private subnet AZ1"
  default     = "10.0.3.0/24"
}

variable "private_subnet_2" {
  description = "Private subnet AZ2"
  default     = "10.0.4.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}