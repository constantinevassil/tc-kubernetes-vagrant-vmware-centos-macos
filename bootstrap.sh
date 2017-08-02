#!/usr/bin/env bash

# su --> password = 'vagrant'
yum check-update
yum -y update

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://yum.kubernetes.io/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
      https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

setenforce 0
# Note: Disabling SELinux by running setenforce 0 is required to allow containers to access the host filesystem, which is required by pod networks for example. You have to do this until SELinux support is improved in the kubelet.

yum install -y docker kubelet kubeadm kubectl kubernetes-cni
systemctl enable docker && systemctl start docker
systemctl enable kubelet && systemctl start kubelet
#  The kubelet is now restarting every few seconds, as it waits in a crashloop for kubeadm to tell it what to do.
sysctl net.bridge.bridge-nf-call-iptables=1
sysctl net.bridge.bridge-nf-call-ip6tables=1

echo "192.168.0.199	centos-master" >> /etc/hosts
# kubeadm init --apiserver-advertise-address 192.168.0.199 --pod-network-cidr 10.244.0.0/16 --token 8c2350.f55343444a6ffc46
# kubectl taint nodes --all node-role.kubernetes.io/master-

# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-rbac.yml


# kubectl get pods -o wide --all-namespaces

