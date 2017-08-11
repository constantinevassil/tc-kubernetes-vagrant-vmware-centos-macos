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

echo "192.168.0.199	tc-centos-master-hatc2" >> /etc/hosts
kubeadm init --apiserver-advertise-address 192.168.0.199 --pod-network-cidr 10.244.0.0/16 --token 8c2350.f55343444a6ffc46

sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl taint nodes --all node-role.kubernetes.io/master-

# Weave Net can be installed onto your CNI-enabled Kubernetes cluster with a single command:
echo "Install Weave Net."
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-rbac.yml

echo "Install Dashboard."
kubectl create -f https://rawgit.com/kubernetes/dashboard/master/src/deploy/kubernetes-dashboard.yaml
kubectl apply -f https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/admin-role.yml

echo "Now I will sleep for 30 seconds."
n=0
while (( $n <= 30 ));
do
	echo -n ".";
	sleep 1;
	((n++));
done
 
echo "Install Grafana."
kubectl create -f https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/heapster/deploy/kube-config/influxdb/grafana.yaml
echo "Now I will sleep for 30 seconds."
n=0
while (( $n <= 30 ));
do
	echo -n ".";
	sleep 1;
	((n++));
doneecho "Install Heapster."
kubectl create -f https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/heapster/deploy/kube-config/influxdb/heapster.yaml
echo "Now I will sleep for 30 seconds."
n=0
while (( $n <= 30 ));
do
	echo -n ".";
	sleep 1;
	((n++));
doneecho "Install Influxdb."
kubectl create -f https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/heapster/deploy/kube-config/influxdb/influxdb.yaml
kubectl create -f https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/heapster/deploy/kube-config/rbac/heapster-rbac.yaml
echo "Now I will sleep for 30 seconds."
n=0
while (( $n <= 30 ));
do
	echo -n ".";
	sleep 1;
	((n++));
done
echo "Install Weave Scope."
kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '\n')"
echo "Now I will sleep for 30 seconds."
n=0
while (( $n <= 30 ));
do
	echo -n ".";
	sleep 1;
	((n++));
done
#--- Do this manually
    
#  ---   
# vagrant ssh
# sudo mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config
# kubectl get nodes
# kubectl get pods -o wide --all-namespaces

# sudo cat /etc/kubernetes/admin.conf > /vagrant/admin.conf

# in the host:
# sudo mkdir -p $HOME/.kube
# sudo cp -i ./admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config
# sudo cat $HOME/.kube/config

# kubectl get pods --all-namespaces
# NAMESPACE     NAME                                     READY     STATUS    RESTARTS   AGE
# kube-system   etcd-tc-k-vm-master                      1/1       Running   0          5m
# kube-system   heapster-84017538-2gnm2                  1/1       Running   0          42s
# kube-system   kube-apiserver-tc-k-vm-master            1/1       Running   0          5m
# kube-system   kube-controller-manager-tc-k-vm-master   1/1       Running   1          6m
# kube-system   kube-dns-2425271678-cqlpt                3/3       Running   0          6m
# kube-system   kube-flannel-ds-3jwjn                    2/2       Running   0          4m
# kube-system   kube-proxy-lcnqq                         1/1       Running   0          6m
# kube-system   kube-scheduler-tc-k-vm-master            1/1       Running   0          5m
# kube-system   kubernetes-dashboard-3313488171-2zt1r    1/1       Running   0          2m
# kube-system   monitoring-grafana-1500490092-r3hbd      1/1       Running   0          43s
# kube-system   monitoring-influxdb-1870447071-9cdjv     1/1       Running   0          42s

# kubectl get svc --all-namespaces
# NAMESPACE     NAME                   CLUSTER-IP       EXTERNAL-IP   PORT(S)         AGE
# default       kubernetes             10.96.0.1        <none>        443/TCP         6m
# kube-system   heapster               10.104.101.10    <none>        80/TCP          57s
# kube-system   kube-dns               10.96.0.10       <none>        53/UDP,53/TCP   6m
# kube-system   kubernetes-dashboard   10.101.14.170    <none>        80/TCP          3m
# kube-system   monitoring-grafana     10.103.100.104   <nodes>       80:30180/TCP    58s
# kube-system   monitoring-influxdb    10.108.159.65    <none>        8086/TCP        57s

# monitoring-grafana: 30180 
# kubectl describe nodes:
# Addresses:
#  InternalIP:	192.168.232.164
#  Hostname:	tc-k-vm-master

# In the browser: 192.168.232.164:30180
