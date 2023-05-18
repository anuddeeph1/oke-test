if [ ! -f $HOME/.kube/config ]; then
  oci ce cluster create-kubeconfig --cluster-id ${cluster-id} --file $HOME/.kube/config  --region ${region} --token-version 2.0.0 --auth instance_principal --kube-endpoint PRIVATE_ENDPOINT

  chmod go-r $HOME/.kube/config
fi
