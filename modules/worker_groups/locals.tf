locals {
  asg_tags = [
    for item in keys(var.tags) :
    map(
      "key", item,
      "value", element(values(var.tags), index(keys(var.tags), item)),
      "propagate_at_launch", "true"
    )
  ]

  worker_security_group_id  = var.worker_security_group_id == "" ? join("", aws_security_group.workers.*.id) : var.worker_security_group_id
  # Merge defaults and per-group values to make code cleaner

  worker_groups_launch_template_expanded = { for k, v in var.worker_groups : k => merge(
    var.workers_group_defaults,
    v,
  ) if var.create_eks && upper(v["type"]) == "LT"}

  worker_groups_expanded = { for k, v in var.worker_groups : k => merge(
    var.workers_group_defaults,
    v,
  ) if var.create_eks && upper(v["type"]) == "LC"}
}
