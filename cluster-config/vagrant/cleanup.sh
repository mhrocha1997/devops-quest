
kubectl config delete-context k3s-cluster || true
kubectl config delete-user k3s-${USER} || true
kubectl config delete-cluster k3s-cluster || true
rm -rf .userconfig