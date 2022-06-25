resource "vault_mount" "dns-pub1-" {
  path        = "kvv1"
  type        = "kv"
  options     = { version = "1" }
  description = "KV Version 1 secret engine mount"
}
