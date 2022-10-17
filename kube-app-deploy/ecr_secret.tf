
data "aws_ecr_authorization_token" "ecr_token" {
  registry_id = "274037641416"
}

resource "kubernetes_secret" "ecr_secret" {
  depends_on = [data.aws_ecr_authorization_token.ecr_token, ]
  metadata {
    name      = "aws-ecr-docker-config"
    namespace = kubernetes_namespace.k8s_namespace.metadata.0.name
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${data.aws_ecr_authorization_token.ecr_token.proxy_endpoint}" = {
          auth = "${data.aws_ecr_authorization_token.ecr_token.authorization_token}"
        }
      }
    })
  }

  type = "kubernetes.io/dockerconfigjson"
}
