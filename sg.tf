resource "aws_security_group" "endpoint_sg" {
  name = "endpoint_sg"
  description = "Endpoint Security Group for HTTPS"
  vpc_id = aws_vpc.this.id
  ingress {
      cidr_blocks = [ aws_vpc.this.cidr_block ]
      description = "Allow https within VPC"
      protocol = "tcp"
      from_port = 443
      to_port = 443
  }
}