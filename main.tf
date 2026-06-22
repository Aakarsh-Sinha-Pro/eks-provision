# # Copyright (c) HashiCorp, Inc.
# # SPDX-License-Identifier: MPL-2.0

# provider "aws" {
#   region = var.region
# }

# # Filter out local zones, which are not currently supported 
# # with managed node groups
# # data "aws_availability_zones" "available" {
# #   filter {
# #     name   = "opt-in-status"
# #     values = ["opt-in-not-required"]
# #   }
# # }

# locals {
#   cluster_name = "eks-aakarsh-cluster-v5"
# }

# # resource "random_string" "suffix" {
# #   length  = 8
# #   special = false
# # }

# # module "vpc" {
# #   source  = "terraform-aws-modules/vpc/aws"
# #   version = "5.8.1"

# #   name = "eks-aakarsh-vpc"

# #   cidr = "10.0.0.0/16"
# #   # azs  = slice(data.aws_availability_zones.available.names, 0, 3)
# #   azs = ["us-east-2a", "us-east-2b", "us-east-2c"]

# #   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# #   public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

# #   enable_nat_gateway   = true
# #   single_nat_gateway   = true
# #   enable_dns_hostnames = true

# #   public_subnet_tags = {
# #     "kubernetes.io/role/elb" = 1
# #   }

# #   private_subnet_tags = {
# #     "kubernetes.io/role/internal-elb" = 1
# #   }
# # }

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 21.0"

#   name    = local.cluster_name
#   kubernetes_version = "1.35"

#   create_iam_role = false  # Tells Terraform NOT to create the control plane role
#   iam_role_arn    = "arn:aws:iam::691879165105:role/CCL-EKS-Role" # Use existing control plane role

#   # Bypasses creation of a new KMS Key (which also requires IAM permissions)
#   create_node_security_group = true
#   create_security_group = true # FIXED: Blocks control plane SG creation

#   enable_irsa = false
#   endpoint_public_access = true

#   enable_cluster_creator_admin_permissions = false

#   authentication_mode = "API_AND_CONFIG_MAP"

#   access_entries = {
#     admin_user = {
#       principal_arn     = "arn:aws:iam::691879165105:user/2492176"
#       type              = "STANDARD"
#       policy_associations = {
#         admin = {
#           policy_arn = "arn:aws:iam::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
#           access_scope = {
#             type = "cluster"
#           }
#         }
#       }
#     }
#   }

#   # cluster_addons = {
#   #   aws-ebs-csi-driver = {
#   #     service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
#   #   }
#   # }

#   # vpc_id     = module.vpc.vpc_id
#   # subnet_ids = module.vpc.private_subnets

#   vpc_id = "vpc-3af53251"
#   subnet_ids = ["subnet-03426cca90ce6d80b", "subnet-003f5e1c0abc2ff75", "subnet-0ec2990e4c42fb65e"]

#   addons = {
#     vpc-cni = {
#       most_recent                 = true
#       resolve_conflicts_on_create = "OVERWRITE"
#       resolve_conflicts_on_update = "OVERWRITE"
#     }
#     kube-proxy = {
#       most_recent                 = true
#       resolve_conflicts_on_create = "OVERWRITE"
#       resolve_conflicts_on_update = "OVERWRITE"
#     }
#     coredns = {
#       most_recent                 = true
#       resolve_conflicts_on_create = "OVERWRITE"
#       resolve_conflicts_on_update = "OVERWRITE"
#     }
#   }

#   eks_managed_node_groups = {
#     one = {
#       name = "node-group-1"

#       instance_types = ["t3.small"]

#       min_size     = 1
#       max_size     = 3
#       desired_size = 1

#       ami_type = "AL2023_x86_64_STANDARD"
#       create_iam_role = false # Tells Terraform NOT to create new node roles
#       iam_role_arn    = "arn:aws:iam::691879165105:role/CCL-EKS-NodeRole" # Use existing node group role
#     }

#     # two = {
#     #   name = "node-group-2"

#     #   instance_types = ["t3.small"]

#     #   min_size     = 1
#     #   max_size     = 2
#     #   desired_size = 1

#     #   ami_type = "AL2023_x86_64_STANDARD"
#     #   create_iam_role = false # Tells Terraform NOT to create new node roles
#     #   iam_role_arn    = "arn:aws:iam::691879165105:role/CCL-EKS-NodeRole" # Use existing node group role
#     # }
#   }
# }


# # # https://aws.amazon.com/blogs/containers/amazon-ebs-csi-driver-is-now-generally-available-in-amazon-eks-add-ons/ 
# # data "aws_iam_policy" "ebs_csi_policy" {
# #   arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
# # }

# # module "irsa-ebs-csi" {
# #   source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
# #   version = "5.39.0"

# #   create_role                   = true
# #   role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
# #   provider_url                  = module.eks.oidc_provider
# #   role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
# #   oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
# # }



















# # Copyright (c) HashiCorp, Inc.
# # SPDX-License-Identifier: MPL-2.0

# provider "aws" {
#   region = var.region
# }

# locals {
#   cluster_name = "eks-aakarsh-cluster-v7"
# }

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 21.0"

#   name               = local.cluster_name
#   kubernetes_version = "1.35"

#   create_iam_role = false  # Tells Terraform NOT to create the control plane role
#   iam_role_arn    = "arn:aws:iam::691879165105:role/CCL-EKS-Role" # Use existing control plane role

#   # Bypasses creation of a new KMS Key (which also requires IAM permissions)
#   create_node_security_group = true
#   create_security_group      = true # FIXED: Blocks control plane SG creation

#   enable_irsa            = false
#   endpoint_public_access  = true
#   endpoint_private_access = true # FIXED: Allows internal communication within the VPC subnet

#   enable_cluster_creator_admin_permissions = false

#   # FIXED: Removed the space to match correct AWS API parameters
#   authentication_mode = "API_AND_CONFIG_MAP"

#   # FIXED: Remapped with proper structural types and accurate system policy ARNs
#   access_entries = {
#     admin_user = {
#       principal_arn     = "arn:aws:iam::691879165105:user/2492176"
#       type              = "STANDARD"
#       policy_associations = {
#         admin = {
#           policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy" # FIXED: Changed 'iam' to 'eks'
#           access_scope = {
#             type = "cluster"
#           }
#         }
#       }
#     }
#     # FIXED: Added the custom nodes configuration so they register correctly automatically
#     worker_nodes = {
#       principal_arn = "arn:aws:iam::691879165105:role/CCL-EKS-NodeRole"
#       type          = "EC2_LINUX"
#     }
#   }

#   vpc_id     = "vpc-3af53251"
#   subnet_ids = ["subnet-03426cca90ce6d80b", "subnet-003f5e1c0abc2ff75", "subnet-0ec2990e4c42fb65e"]

#   # Enforces early setup rules alongside cluster creation loops
#   addons = {
#     vpc-cni = {
#       most_recent                 = true
#       resolve_conflicts_on_create = "OVERWRITE"
#       resolve_conflicts_on_update = "OVERWRITE"
#     }
#     kube-proxy = {
#       most_recent                 = true
#       resolve_conflicts_on_create = "OVERWRITE"
#       resolve_conflicts_on_update = "OVERWRITE"
#     }
#     coredns = {
#       most_recent                 = true
#       resolve_conflicts_on_create = "OVERWRITE"
#       resolve_conflicts_on_update = "OVERWRITE"
#     }
#   }

#   eks_managed_node_groups = {
#     one = {
#       name = "node-group-1"

#       instance_types = ["t3.small"]

#       min_size     = 1
#       max_size     = 3
#       desired_size = 1

#       ami_type        = "AL2023_x86_64_STANDARD"
#       create_iam_role = false # Tells Terraform NOT to create new node roles
#       iam_role_arn    = "arn:aws:iam::691879165105:role/CCL-EKS-NodeRole" # Use existing node group role
#     }
#   }
# }




# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

locals {
  cluster_name = "eks-aakarsh-cluster-v7"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.cluster_name
  kubernetes_version = "1.35"

  create_iam_role = false  
  iam_role_arn    = "arn:aws:iam::691879165105:role/CCL-EKS-Role" 

  create_node_security_group = true
  create_security_group      = true 

  enable_irsa            = false
  endpoint_public_access  = true
  endpoint_private_access = true 

  enable_cluster_creator_admin_permissions = false
  
  # FIXED: Set to the validated string to satisfy the Terraform validation engine
  authentication_mode = "API_AND_CONFIG_MAP"

  # Structural rule to automatically map port 443 for your local network jumpbox
  security_group_additional_rules = {
    ingress_ec2_jumpbox = {
      description = "Allow administrative jumpbox subnet to reach EKS API Control Plane"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = ["172.31.0.0/16"] 
    }
  }

  access_entries = {
    admin_user = {
      principal_arn     = "arn:aws:iam::691879165105:user/2492176"
      type              = "STANDARD"
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy" 
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
    worker_nodes = {
      principal_arn = "arn:aws:iam::691879165105:role/CCL-EKS-NodeRole"
      type          = "EC2_LINUX"
    }
  }

  vpc_id     = "vpc-3af53251"
  subnet_ids = ["subnet-03426cca90ce6d80b", "subnet-003f5e1c0abc2ff75", "subnet-0ec2990e4c42fb65e"]

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 1

      ami_type        = "AL2023_x86_64_STANDARD"
      create_iam_role = false 
      iam_role_arn    = "arn:aws:iam::691879165105:role/CCL-EKS-NodeRole" 
    }
  }
}

# Isolated addon resources with explicit creation dependencies
resource "aws_eks_addon" "addons" {
  for_each = toset(["vpc-cni", "kube-proxy", "coredns"])

  cluster_name                = module.eks.cluster_name
  addon_name                  = each.key
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  # Forces addons to wait until node groups settle to prevent initialization hangs
  depends_on = [module.eks.eks_managed_node_groups]
}