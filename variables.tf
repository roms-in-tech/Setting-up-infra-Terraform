variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "subnet_cidr_block_1" {
  description = "CIDR block for the first private subnet."
  type        = string
}

variable "subnet_cidr_block_2" {
  description = "CIDR block for the second private subnet."
  type        = string
}

variable "subnet_cidr_block_public_1" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance."
  type        = string 
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
}

variable "db_engine" {
  description = "The database engine for the RDS instance."
  type        = string
}

variable "db_engine_version" {
  description = "The database engine version for the RDS instance."
  default     = "5.7"
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance."
  type        = string
}

variable "db_username" {
  description = "The username for accessing the RDS instance."
  type        = string
}

variable "db_password" {
  description = "The password for accessing the RDS instance."
  type        = string
}