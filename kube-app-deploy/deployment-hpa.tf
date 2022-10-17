# resource "kubernetes_manifest" "deployment-hpa" {
#   manifest = {
#     "apiVersion" = "autoscaling/v2beta2"
#     "kind"       = "HorizontalPodAutoscaler"
#     "metadata" = {
#       "name"      = "${var.name}-hpa"
#       "namespace" = kubernetes_deployment.deployment.metadata.0.namespace
#     }
#     "spec" = {
#       "behavior" = {
#         "scaleDown" = {
#           "policies" = [
#             {
#               "periodSeconds" = 180
#               "type"          = "Pods"
#               "value"         = 1
#             },
#             {
#               "periodSeconds" = 180
#               "type"          = "Percent"
#               "value"         = 10
#             },
#           ]
#           "stabilizationWindowSeconds" = 300
#         }
#         "scaleUp" = {
#           "policies" = [
#             {
#               "periodSeconds" = 180
#               "type"          = "Percent"
#               "value"         = 100
#             },
#             {
#               "periodSeconds" = 180
#               "type"          = "Pods"
#               "value"         = 1
#             },
#           ]
#           "stabilizationWindowSeconds" = 300
#         }
#       }
#       "maxReplicas" = var.max_number_of_replicas
#       "minReplicas" = var.number_of_replicas
#       "scaleTargetRef" = {
#         "apiVersion" = "apps/v1"
#         "kind"       = "Deployment"
#         "name"       = kubernetes_deployment.deployment.metadata.0.name
#       }
#     }
#   }
# }
