# terraform-bastion
bastion terraform module
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed\_cidr\_blocks | A list of CIDR blocks allowed to connect | list | `<list>` | no |
| ami | AMI to use | string | `ami-efd0428f` | no |
| instance\_type | Ec2 instance type | string | `t2.micro` | no |
| key\_name | Key name | string | `` | no |
| name | Name to be used on all the resources as identifier | string | `` | no |
| remote\_bucket | s3 bucket for remote state | string | `` | no |
| ssh\_user | Default SSH user for this AMI. e.g. `ec2user` for Amazon Linux and `ubuntu` for Ubuntu systems | string | - | yes |
| tags | A map of tags to add to all resources | map | `<map>` | no |
| user\_data | User data content | list | `<list>` | no |
| user\_data\_file | User data file | string | `user_data.sh` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | Instance ID |
| private\_ip | Private IP of the instance |
| public\_ip | Public IP of the instance (or EIP) |
| role | Name of AWS IAM Role associated with the instance |
| security\_group\_id | Security group ID |
| ssh\_user | SSH user |

