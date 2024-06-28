provider "aws" {
  region  = var.region
  profile = var.profile
}


module "eks-jx" {
  source                               = "../../"
  install_kuberhealthy                 = true
  create_nginx                         = true
  cluster_version                      = "1.21"
  nginx_chart_version                  = "3.12.0"
  enable_worker_groups_launch_template = true
  volume_type                          = "gp3"
  volume_size                          = "100"
  encrypt_volume_self                  = true
  boot_secrets = [
    {
      name  = "jxBootJobEnvVarSecrets.EXTERNAL_VAULT"
      value = "true"
      type  = "string"
    },
    {
      name  = "jxBootJobEnvVarSecrets.VAULT_ADDR"
      value = "http://external-vault:8200"
      type  = "string"
    }
  ]
}
