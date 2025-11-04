variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Ubuntu24  AMI ID"
  default     = "ami-0ecb62995f68bb549" # us-east-1
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "VPC ID where EC2 should be created"
  default     = "vpc-00c21ddd4a443b0f7" # Replace with your VPC ID
}

variable "ssh_public_key" {
  description = "Your SSH public key"
  type        = string
}

variable "allowed_cidr" {
  description = "CIDR block allowed to access EC2"
  type        = string
}

