locals {
  # List with supported autoscaler images: https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengusingclusterautoscaler.htm
  autoscaler_image = {
    "v1.22.5" = "phx.ocir.io/oracle/oci-cluster-autoscaler:1.22.2-4",
    "v1.23.4" = "phx.ocir.io/oracle/oci-cluster-autoscaler:1.23.0-4",
    "v1.24.1" = "phx.ocir.io/oracle/oci-cluster-autoscaler:1.24.0-5"
    "v1.25.4" = "phx.ocir.io/oracle/oci-cluster-autoscaler:1.25.0-6"
  }
}
