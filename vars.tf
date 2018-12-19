variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = "string"
  default     = ""
}

variable "ssh_user" {
  description = "Default SSH user for this AMI. e.g. `ec2user` for Amazon Linux and `ubuntu` for Ubuntu systems"
  type        = "string"
}

variable "key_name" {
  description = "Key name"
  type        = "string"
  default     = ""
}

variable "instance_type" {
  description = "Ec2 instance type"
  type        = "string"
  default     = "t2.micro"
}

variable "ami" {
  description = "AMI to use"
  type        = "string"
  default     = "ami-efd0428f"
}

variable "allowed_cidr_blocks" {
  description = "A list of CIDR blocks allowed to connect"
  type        = "list"

  default = [
    "0.0.0.0/0",
  ]
}

# User data provisioning
variable "user_data_file" {
  description = "User data file"
  type        = "string"
  default     = "user_data.sh"
}

variable "user_data" {
  description = "User data content"
  type        = "list"
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
