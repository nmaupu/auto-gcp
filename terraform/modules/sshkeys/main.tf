data "template_file" "default" {
  count    = "${length(keys(var.credentials))}"
  template = "$${user}:$${key}"

  vars {
    user = "${element(keys(var.credentials), count.index)}"
    key  = "${element(values(var.credentials), count.index)}"
  }
}

resource "google_compute_project_metadata_item" "default" {
  key     = "ssh-keys"
  value   = "${join("\n", data.template_file.default.*.rendered)}"
  project = "${var.project}"
}
