module "backup-bucket" {
  source  = "../../modules/storage/bucket"

  name = "${var.backup_bucket_name}"
  project = "${data.terraform_remote_state.projects.kube.project_id}"
  location = "${var.region}"
  storage_class = "${var.backup_bucket_storage_class}"

  versioning = "false"
}
