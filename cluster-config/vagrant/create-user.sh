#!/bin/bash

set -e

MASTER_IP=$1
CLUSTER_NAME=$2
KUBE_USER=${CLUSTER_NAME}-${USER}
VAGRANT_MASTER_NAME=${CLUSTER_NAME}-master



GROUP="admin"
SERVER=https://${MASTER_IP}:6443



echo "===> Generating keys and certificates on master node..."
vagrant ssh ${VAGRANT_MASTER_NAME} -c "
  openssl genrsa -out /home/vagrant/${KUBE_USER}.key 2048 &&
  openssl req -new -key /home/vagrant/${KUBE_USER}.key -out /home/vagrant/${KUBE_USER}.csr -subj '/CN=${KUBE_USER}/O=${GROUP}' &&
  sudo openssl x509 -req -in /home/vagrant/${KUBE_USER}.csr \
    -CA /var/lib/rancher/k3s/server/tls/server-ca.crt \
    -CAkey /var/lib/rancher/k3s/server/tls/server-ca.key \
    -CAcreateserial -out /home/vagrant/${KUBE_USER}.crt -days 365 &&
  sudo cp /var/lib/rancher/k3s/server/tls/server-ca.crt /home/vagrant/
" 

echo "===> Copying files to host..."

rm -rf .userconfig
mkdir -p .userconfig

vagrant ssh ${VAGRANT_MASTER_NAME} -c "cat /home/vagrant/${KUBE_USER}.crt" > ./.userconfig/${KUBE_USER}.crt
vagrant ssh ${VAGRANT_MASTER_NAME} -c "cat /home/vagrant/${KUBE_USER}.key" > ./.userconfig/${KUBE_USER}.key
vagrant ssh ${VAGRANT_MASTER_NAME} -c "cat /home/vagrant/server-ca.crt" > ./.userconfig/server-ca.crt



vagrant ssh ${VAGRANT_MASTER_NAME} -c "sudo kubectl create clusterrolebinding ${KUBE_USER}-admin --clusterrole=cluster-admin --user=${KUBE_USER}"
vagrant ssh ${VAGRANT_MASTER_NAME} -c "sudo kubectl create serviceaccount ${KUBE_USER}-token"
vagrant ssh ${VAGRANT_MASTER_NAME} -c "sudo kubectl create clusterrolebinding ${KUBE_USER}-token-admin --clusterrole=cluster-admin --serviceaccount=default:${KUBE_USER}-token"
TOKEN=$(vagrant ssh ${VAGRANT_MASTER_NAME} -c "sudo kubectl create token ${KUBE_USER}-token")

echo "===> Generating kubeconfig..."
cat > ./.userconfig/${KUBE_USER}-kubeconfig.yaml <<EOF
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority: ./server-ca.crt
    server: $SERVER
  name: k3s-cluster
users:
- name: ${KUBE_USER}
  user:
    client-certificate: ./$(basename ${KUBE_USER}.crt)
    client-key: ./$(basename ${KUBE_USER}.key)
    token: ${TOKEN}
contexts:
- context:
    cluster: k3s-cluster
    user: ${KUBE_USER}
  name: k3s-cluster
current-context: k3s-cluster
EOF

cp ~/.kube/config ~/.kube/config.bkp.$(date +%Y%m%d%H%M%S)

echo "Merging Kubeconfigs..." 
export KUBECONFIG=~/.kube/config:$(pwd)/.userconfig/${KUBE_USER}-kubeconfig.yaml
kubectl config view --flatten > /tmp/kubeconfig.merged.yaml

echo "Validating new kubeconfig..."

if kubectl --kubeconfig=/tmp/kubeconfig.merged.yaml config get-contexts > /dev/null 2>&1; then
  echo "New kubeconfig is valid! Applying..."
  mv /tmp/kubeconfig.merged.yaml ~/.kube/config
  echo "Merged! Test: kubectl get nodes"
else
  echo "ATTENTION: Invalid kubeconfig generated! ~/.kube/config was not changed."
  exit 1
fi
