output "name" {
  value = "${google_storage_bucket.default.name}"
}

output "self_link" {
  value = "${google_storage_bucket.default.self_link}"
}

output "url" {
  value = "${google_storage_bucket.default.url}"
}
