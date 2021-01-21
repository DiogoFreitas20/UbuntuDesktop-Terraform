resource "aws_instance" "emailsrv" {
  ami = "ami-0885b1f6bd170450c"
  instance_type = "t2.micro"
  key_name = var.key_name
  security_groups = [
    aws_security_group.instance.name,
  ]
  tags = {
    "Name" = var.instance_name
  }

  vpc_security_group_ids = [
    aws_security_group.instance.id,
  ]
  root_block_device {
    volume_size = var.volume_size
  }
  user_data = data.template_cloudinit_config.config.rendered

}

# aws_security_group.instance:
resource "aws_security_group" "instance" {
  name = var.security_group_name
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description = ""
      from_port = 0
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "-1"
      security_groups = []
      self = false
      to_port = 0
    },
  ]
  ingress = [
  for _fw_rule in var.fw_rules:
  {
    cidr_blocks = [
    for _ip in var.ip_list:
    _ip
    ]
    description = _fw_rule[3]
    from_port = _fw_rule[1]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = _fw_rule[0]
    security_groups = []
    self = false
    to_port = _fw_rule[2]
  }
  ]
}
