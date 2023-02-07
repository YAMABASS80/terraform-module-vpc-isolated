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

## VPC Endpoint for Amazon S3 (Gateway)
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.this.id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
  tags = {
    "Name" = "${var.resource_tag_prefix}_s3_endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "private_subnet_1" {
  route_table_id  = aws_route_table.private_subnet_1_route_table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_vpc_endpoint_route_table_association" "private_subnet_2" {
  route_table_id  = aws_route_table.private_subnet_2_route_table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}