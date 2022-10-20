# ---------------------------------------------------------------------------------------------------------------------
# MANAGED NODE GROUPS
# ---------------------------------------------------------------------------------------------------------------------

module "aws_eks_managed_node_groups" {
  source = "../aws-eks-managed-node-groups"

  for_each = var.managed_node_groups

  managed_ng = each.value
  context    = local.node_group_context

  depends_on = [kubernetes_config_map.aws_auth]
}

# ---------------------------------------------------------------------------------------------------------------------
# SELF MANAGED NODE GROUPS
# ---------------------------------------------------------------------------------------------------------------------

module "aws_eks_self_managed_node_groups" {
  source = "../aws-eks-self-managed-node-groups"

  for_each = var.self_managed_node_groups

  self_managed_ng = each.value
  context         = local.node_group_context

  depends_on = [kubernetes_config_map.aws_auth]
}

# ---------------------------------------------------------------------------------------------------------------------
# FARGATE PROFILES
# ---------------------------------------------------------------------------------------------------------------------

module "aws_eks_fargate_profiles" {
  source = "../aws-eks-fargate-profiles"

  for_each = var.fargate_profiles

  fargate_profile = each.value
  context         = local.fargate_context

  depends_on = [kubernetes_config_map.aws_auth]
}
