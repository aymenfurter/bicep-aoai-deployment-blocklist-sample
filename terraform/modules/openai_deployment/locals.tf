locals {
  blocklist_items = split("\n", file("${path.module}/blocklist_items.txt"))
}