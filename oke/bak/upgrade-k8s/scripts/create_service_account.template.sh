
if [ ! -f .sa_completed ]; then
  if [ ${service_account_namespace} != kube-system ]; then
    kubectl create ns ${service_account_namespace}
  fi

  kubectl -n ${service_account_namespace} create serviceaccount ${service_account_name}

  kubectl create clusterrolebinding ${service_account_cluster_role_binding} --clusterrole=cluster-admin --serviceaccount=${service_account_namespace}:${service_account_name}
  touch .sa_completed
fi 
