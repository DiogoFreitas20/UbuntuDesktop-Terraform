variable "instance_name" {
  type = string
  default = "doublesrv"
}

variable "key_name" {
  type = string
  default = "GRSI-KEY"
}

variable "volume_size" {
  type = number
  default = 30
}

variable "security_group_name" {
  type = string
  default = "Ubuntu Weberver security group"
}

variable "cloud_config" {
  type = string
  default = "cloud-config.sh"
}

variable "fw_rules" {
  description = "Firewall rules"
  type = list(tuple([string, number, number, string]))
  default = [
    ["tcp", 22, 22, "Allow SSH"],
    ["tcp", 80, 80, "Allow HTTP"],
    ["tcp", 3389, 3389, "Allow RDP"],
  ]
}

variable "ip_list" {
  description = "Allowed IPs"
  type = list(string)
  default = [
    "78.29.170.44",
    "10.0.1.0/16"
  ]
}

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
  default     = "terraform-asg-example"
}

variable "alb_security_group_name" {
  description = "The name of the security group for the ALB"
  type        = string
  default     = "terraform-example-alb"
}
