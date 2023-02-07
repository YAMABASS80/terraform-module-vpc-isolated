resource "aws_vpc_endpoint" "endpoints" {
  vpc_id            = aws_vpc.this.id
  for_each = toset(var.vpc_endpoints) 
  service_name      = "com.amazonaws.${data.aws_region.current.name}.${each.key}"
  tags = {
    "Name" = "${var.resource_tag_prefix}_${each.key}_endpoint"
  }
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = true
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
  ]
}