# K3s Cluster with Vagrant

This directory contains the configuration to spin up a K3s cluster using Vagrant with 1 master and 2 workers.

## Requirements

- [Vagrant](https://www.vagrantup.com/downloads) >= 2.0
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) >= 6.0
- kubectl (to manage the cluster)

## Cluster Configuration

### Topology
- **Master**: k3s-master (192.168.56.10) - 2 CPUs, 2GB RAM
- **Worker1**: k3s-worker1 (192.168.56.11) - 2 CPUs, 4GB RAM  
- **Worker2**: k3s-worker2 (192.168.56.12) - 2 CPUs, 4GB RAM

### Scripts

- **k3s-master.sh**: Installs K3s on master node and configures kubectl
- **k3s-worker.sh**: Installs K3s agent on workers and connects to master
- **create-user.sh**: Creates custom user and configures local kubeconfig
- **cleanup.sh**: Removes cluster configurations from local kubeconfig when running `vagrant destroy`

## How to use

### Go to Vagrant Directory
```bash
cd cluster-config/vagrant
```

### Start the cluster
```bash
vagrant up
```

### Check status
```bash
kubectl get nodes
```

### Destroy the cluster
```bash
vagrant destroy
```

## Notes

- Kubeconfig is automatically configured in your `~/.kube/config`
- A backup of the previous kubeconfig is created before configuration
