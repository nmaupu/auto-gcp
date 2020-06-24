##
# network and subnetwork for the project
##
module "network" {
  source  = "../../modules/compute/network"
  name    = var.network_name
  project = data.terraform_remote_state.projects.outputs.kube_project_id
}

module "subnetwork" {
  source        = "../../modules/compute/subnetwork"
  name          = var.subnetwork_name
  network       = module.network.self_link
  ip_cidr_range = var.cidr
  project       = data.terraform_remote_state.projects.outputs.kube_project_id
}

