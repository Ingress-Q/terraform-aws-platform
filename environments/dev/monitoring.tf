module "monitoring" {
  source = "../../modules/monitoring"

  grafana_admin_password = var.grafana_admin_password
}