
# # # ? Create a k3d cluster
resource "null_resource" "create_k3d_cluster" {
  provisioner "local-exec" {
    command     = "${path.module}./linux/k3d_prepare.sh"
    interpreter = ["/bin/bash", "-c"]
  }
}

