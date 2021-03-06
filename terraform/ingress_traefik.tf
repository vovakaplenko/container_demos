# Create Static Public IP Address to be used by Traefik Ingress
resource "azurerm_public_ip" "traefik_ingress" {
  name                         = "traefik-ingress-pip"
  location                     = azurerm_kubernetes_cluster.akstf.location
  resource_group_name          = azurerm_kubernetes_cluster.akstf.node_resource_group
  allocation_method            = "Static"
  sku                          = "Standard"
  domain_name_label            = var.dns_prefix

  depends_on = [azurerm_kubernetes_cluster.akstf]
}

resource "kubernetes_namespace" "traefik-ns" {
  metadata {
    name = "traefik"
  }

  depends_on = [azurerm_kubernetes_cluster.akstf]
}

# Install traefik Ingress using Helm Chart
# https://github.com/helm/charts/tree/master/stable/traefik
# https://www.terraform.io/docs/providers/helm/release.html
resource "helm_release" "traefik_ingress" {
  name       = "traefikingress"
  repository = "https://kubernetes-charts.storage.googleapis.com" 
  chart      = "traefik"
  namespace  = "traefik"
  force_update = "true"
  timeout = "500"

  values = [
    file("${path.module}/traefik.yaml"),
  ]

  set {
    name  = "replicas"
    value = "2"
  }

  set {
    name  = "externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "loadBalancerIP"
    value = azurerm_public_ip.traefik_ingress.ip_address
  }
  
  depends_on = [azurerm_kubernetes_cluster.akstf, kubernetes_namespace.traefik-ns, azurerm_public_ip.traefik_ingress, null_resource.after_charts]
}