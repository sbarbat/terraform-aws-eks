# eks `node_groups` submodule

Helper submodule to create and manage resources related to `eks_node_groups`.

## Assumptions
* Designed for use by the parent module and not directly by end users

## Node Groups' IAM Role
The role ARN specified in `var.default_iam_role_arn` will be used by default. In a simple configuration this will be the worker role created by the parent module.

`iam_role_arn` must be specified in either `var.node_groups_defaults` or `var.node_groups` if the default parent IAM role is not being created for whatever reason, for example if `manage_worker_iam_resources` is set to false in the parent.

## `node_groups` and `node_groups_defaults` keys
`node_groups_defaults` is a map that can take the below keys. Values will be used if not specified in individual node groups.

`node_groups` is a map of maps. Key of first level will be used as unique value for `for_each` resources and in the `aws_eks_node_group` name. Inner map can take the below values.

| Name | Description | Type | If unset |
|------|-------------|:----:|:-----:|
| additional\_tags | Additional tags to apply to node group | map(string) | Only `var.tags` applied |
| ami\_release\_version | AMI version of workers | string | Provider default behavior |
| ami\_type | AMI Type. See Terraform or AWS docs | string | Provider default behavior |
| capacity\_type | Type of instance capacity to provision. Options are `ON_DEMAND` and `SPOT` | string | Provider default behavior |
| desired\_capacity | Desired number of workers | number | `var.workers_group_defaults[asg_desired_capacity]` |
| disk\_size | Workers' disk size | number | Provider default behavior |
| disk\_type | Workers' disk type. Require `create_launch_template` to be `true`| number | `gp3` |
| iam\_role\_arn | IAM role ARN for workers | string | `var.default_iam_role_arn` |
| instance\_types | Node group's instance type(s). Multiple types can be specified when `capacity_type="SPOT"`. | list | `[var.workers_group_defaults[instance_type]]` |
| k8s\_labels | Kubernetes labels | map(string) | No labels applied |
| key\_name | Key name for workers. Set to empty string to disable remote access | string | `var.workers_group_defaults[key_name]` |
| launch_template_id | The id of a aws_launch_template to use | string | No LT used |
| launch\_template_version | The version of the LT to use | string | none |
| max\_capacity | Max number of workers | number | `var.workers_group_defaults[asg_max_size]` |
| min\_capacity | Min number of workers | number | `var.workers_group_defaults[asg_min_size]` |
| name | Name of the node group | string | Auto generated |
| source\_security\_group\_ids | Source security groups for remote access to workers | list(string) | If key\_name is specified: THE REMOTE ACCESS WILL BE OPENED TO THE WORLD |
| subnets | Subnets to contain workers | list(string) | `var.workers_group_defaults[subnets]` |
| version | Kubernetes version | string | Provider default behavior |
| create_launch_template | Create and use a default launch template | bool |  `false` |
| kubelet_extra_args | This string is passed directly to kubelet if set. Useful for adding labels or taints. Require `create_launch_template` to be `true`| string | "" |
| enable_monitoring | Enables/disables detailed monitoring. Require `create_launch_template` to be `true`| bool | `true` |
| eni_delete | Delete the Elastic Network Interface (ENI) on termination (if set to false you will have to manually delete before destroying) | bool | `true` |
| public_ip | Associate a public ip address with a worker. Require `create_launch_template` to be `true`| string | `false`
| pre_userdata | userdata to pre-append to the default userdata. Require `create_launch_template` to be `true`| string | "" |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| cloudinit | n/a |
| random | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_eks_node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) |
| [aws_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) |
| [cloudinit_config](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) |
| [random_pet](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name of parent cluster | `string` | n/a | yes |
| create\_eks | Controls if EKS resources should be created (it affects almost all resources) | `bool` | `true` | no |
| default\_iam\_role\_arn | ARN of the default IAM worker role to use if one is not specified in `var.node_groups` or `var.node_groups_defaults` | `string` | n/a | yes |
| ng\_depends\_on | List of references to other resources this submodule depends on | `any` | `null` | no |
| node\_groups | Map of maps of `eks_node_groups` to create. See "`node_groups` and `node_groups_defaults` keys" section in README.md for more details | `any` | `{}` | no |
| node\_groups\_defaults | map of maps of node groups to create. See "`node_groups` and `node_groups_defaults` keys" section in README.md for more details | `any` | n/a | yes |
| tags | A map of tags to add to all resources | `map(string)` | n/a | yes |
| worker\_additional\_security\_group\_ids | A list of additional security group ids to attach to worker instances | `list(string)` | `[]` | no |
| worker\_security\_group\_id | If provided, all workers will be attached to this security group. If not given, a security group will be created with necessary ingress/egress to work with the EKS cluster. | `string` | `""` | no |
| workers\_group\_defaults | Workers group defaults from parent | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_auth\_roles | Roles for use in aws-auth ConfigMap |
| node\_groups | Outputs from EKS node groups. Map of maps, keyed by `var.node_groups` keys. See `aws_eks_node_group` Terraform documentation for values |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
