# VPC Overview

Isolated VPC. There's no Internet gateway, Nat gateway however you can access resource within this VPC using SSM session manager.

# Parameters
|  Name  |  Type  | Description  |
| ---- | ---- | ---- |
|  vpc_cidr_block  |  string  | VPC CIDR range  |

# Outputs
|  Name  |  Type  | Description  |
| ---- | ---- | ---- |
|  vpc_id  |  string  | VPC ID  |
|  vpc_cidr  |  string  | VPC CIDR  |
|  private_subnet_1_id |  string  | Private Subnet 1 ID  |
|  private_subnet_2_id  |  string  | Private Subnet 1 ID  |
|  private_subnet_1_route_table_id |  string  | Private Subnet 1 Route Table ID |
|  private_subnet_1_route_table_id |  string  | Private Subnet 2 Route Table ID  |