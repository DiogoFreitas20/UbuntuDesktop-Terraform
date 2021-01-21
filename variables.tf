variable "instance_name" {
  type = string
  default = "ubuntudsk"
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
  default = "Ubuntu Desktop security group"
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
    ["tcp", 3389, 3389, "Allow RDP"],
    ["tcp", 80, 80, "Allow HTTP"],
  ]
}

variable "ip_list" {
  description = "Allowed IPs"
  type = list(string)
  default = [
    "78.29.170.44/32"
  ]
}
