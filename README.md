# VPC Overview

This module generates fully isolated VPC environment, where no intenet gateway and NAT gateway. To secure AWS service connectivity, it also generates VPC endpoints you specified. By default, it generates `ssm`,`ec2messages` and `ssmmessages` so that you can access your VPC resource from [SSM Session Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html). You can also add more VPC endpoints depending on your workload.



# Parameters
|  Name  |  Type  | Description  |
| ---- | ---- | ---- |
|  vpc_cidr_block  |  string  | VPC CIDR range  |
|  resource_tag_prefix  |  string  | Resource tag prefix for each resource. (default = "project_1")  |
|  endpoints  |  list(string)  | List of VPC endoint service name, eg) ssm, es2messages (default = ["ssm", "ec2messages", "ssmmessages"])  |


# Outputs
|  Name  |  Type  | Description  |
| ---- | ---- | ---- |
|  vpc_id  |  string  | VPC ID  |
|  vpc_cidr  |  string  | VPC CIDR  |
|  private_subnet_1_id |  string  | Private Subnet 1 ID  |
|  private_subnet_2_id  |  string  | Private Subnet 1 ID  |
|  private_subnet_1_route_table_id |  string  | Private Subnet 1 Route Table ID |
|  private_subnet_1_route_table_id |  string  | Private Subnet 2 Route Table ID |

# Basic Usage

You can import this module from your code base such as, 

```terraform
module "network" {
  source         = "git@github.com:YAMABASS80/terraform-module-vpc-no-nat.git?ref=1.0.0"
  vpc_cidr_block = "10.0.0.0/16"
  resource_tag_prefix = "my_project"
  vpc_endpoints = ["logs"]
}
```

# Integration Parttern

## I want to add more subnets.
```terraform
module "network" {
  source         = "git@github.com:YAMABASS80/terraform-module-vpc-no-nat.git?ref=1.0.0"
  vpc_cidr_block = "10.0.0.0/16"
  resource_tag_prefix = "my_project"
  vpc_endpoints = ["logs"]
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id = module.network.outputs.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 2 )
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.resource_tag_prefix}_private_subnet_3"
  }
}
```
Make sure you start from CIDR block `2` as `0` and `1` are already used in this module.