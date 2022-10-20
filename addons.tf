# data "aws_eks_cluster" "cluster" {
#   name = module.eks_blueprints.eks_cluster_id
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks_blueprints.eks_cluster_id
# }

# module "eks_blueprints_kubernetes_addons" {
#   source = "./modules/kubernetes-addons"

#   eks_cluster_id       = module.eks_blueprints.eks_cluster_id
#   eks_cluster_endpoint = data.aws_eks_cluster.cluster.endpoint
#   eks_oidc_provider    = replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")
#   eks_cluster_version  = data.aws_eks_cluster.cluster.version

#   # EKS Addons
#   enable_amazon_eks_vpc_cni            = true
#   enable_amazon_eks_coredns            = true
#   enable_amazon_eks_kube_proxy         = true
#   enable_amazon_eks_aws_ebs_csi_driver = true

#   enable_velero           = true
#   velero_backup_s3_bucket = module.velero_backup_s3_bucket.s3_bucket_id

#   enable_aws_efs_csi_driver = true

#   enable_self_managed_aws_ebs_csi_driver = true
#   self_managed_aws_ebs_csi_driver_helm_config = {
#     set_values = [
#       {
#         name  = "node.tolerateAllTaints"
#         value = "true"
#     }]
#   }

#   # Argocd
#   enable_argocd = true
#   # This example shows how to set default ArgoCD Admin Password using SecretsManager with Helm Chart set_sensitive values.
#   argocd_helm_config = {
#     set_sensitive = [
#       {
#         name  = "configs.secret.argocdServerAdminPassword"
#         value = bcrypt(data.aws_secretsmanager_secret_version.admin_password_version.secret_string)
#       }
#     ]
#   }

#   argocd_manage_add_ons = true # Indicates that ArgoCD is responsible for managing/deploying add-ons
#   argocd_applications = {
#     addons = {
#       path               = "chart"
#       repo_url           = "https://github.com/aws-samples/eks-blueprints-add-ons.git"
#       add_on_application = true
#     }
#     workloads = {
#       path               = "envs/dev"
#       repo_url           = "https://github.com/aws-samples/eks-blueprints-workloads.git"
#       add_on_application = false
#     }
#   }

#   enable_aws_for_fluentbit  = true
#   enable_cert_manager       = true
#   enable_cluster_autoscaler = true
#   enable_karpenter          = true
#   enable_keda               = true
#   enable_metrics_server     = true
#   enable_prometheus         = true
#   enable_traefik            = true
#   enable_vpa                = true
#   enable_yunikorn           = true
#   enable_argo_rollouts      = true

#   tags = local.tags
# }

# #---------------------------------------------------------------
# # ArgoCD Admin Password credentials with Secrets Manager
# # Login to AWS Secrets manager with the same role as Terraform to extract the ArgoCD admin password with the secret name as "argocd"
# #---------------------------------------------------------------
# resource "random_password" "argocd" {
#   length           = 16
#   special          = true
#   override_special = "!#$%&*()-_=+[]{}<>:?"
# }

# #tfsec:ignore:aws-ssm-secret-use-customer-key
# resource "aws_secretsmanager_secret" "arogcd" {
#   name                    = "argocd"
#   recovery_window_in_days = 0 # Set to zero for this example to force delete during Terraform destroy
# }

# resource "aws_secretsmanager_secret_version" "arogcd" {
#   secret_id     = aws_secretsmanager_secret.arogcd.id
#   secret_string = random_password.argocd.result
# }

# data "aws_secretsmanager_secret_version" "admin_password_version" {
#   secret_id = aws_secretsmanager_secret.arogcd.id

#   depends_on = [aws_secretsmanager_secret_version.arogcd]
# }