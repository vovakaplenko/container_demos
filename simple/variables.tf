# azure subscription id
variable "subscription_id" {
    default = ""
}

# azure ad tenant id
variable "tenant_id" {
    default = ""
}

# variable "terraform_client_id" {
#     default = ""
# }

# variable "terraform_client_secret" {
#     default = ""
# }
# default tags applied to all resources
variable "environment" {
    default = "stg"
}

# number of aks worker nodes
variable "agent_count" {
    default = 3
}

variable "autoscaler" {
    default = true
}

variable "min_agent_count" {
    default = 3
}
variable "max_agent_count" {
    default = 5
}

variable "vm_size" {
    default = "Standard_DS2_v2"
}

# kubernetes version
variable "kubernetes_version" {
    default = "1.14.8"
}
# default ssh key
variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}
# dns prefix used for azure resources
variable "dns_prefix" {
    default = ""
}
# cluster name
variable "cluster_name" {
    default = ""
}
# resource group for all resources
variable "resource_group_name" {
    default = ""
}

variable "location" {
    default = "WestEurope"
}