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

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-rbac.yml


kubectl create -f https://rawgit.com/kubernetes/dashboard/master/src/deploy/kubernetes-dashboard.yaml
kubectl apply -f https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/admin-role.yml

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

# git clone https://github.com/kubernetes/heapster.git
# EDIT: add
# type: NodePort
# grafana.yaml
# apiVersion: extensions/v1beta1
# kind: Deployment
# metadata:
#   name: monitoring-grafana
#   namespace: kube-system
# spec:
#   replicas: 1
#   template:
#     metadata:
#       labels:
#         task: monitoring
#         k8s-app: grafana
#     spec:
#       containers:
#       - name: grafana
#         image: gcr.io/google_containers/heapster-grafana-amd64:v4.4.1
#         ports:
#         - containerPort: 3000
#           protocol: TCP
#         volumeMounts:
#         - mountPath: /var
#           name: grafana-storage
#         env:
#         - name: INFLUXDB_HOST
#           value: monitoring-influxdb
#         - name: GF_SERVER_HTTP_PORT
#           value: "3000"
#           # The following env variables are required to make Grafana accessible via
#           # the kubernetes api-server proxy. On production clusters, we recommend
#           # removing these env variables, setup auth for grafana, and expose the grafana
#           # service using a LoadBalancer or a public IP.
#         - name: GF_AUTH_BASIC_ENABLED
#           value: "false"
#         - name: GF_AUTH_ANONYMOUS_ENABLED
#           value: "true"
#         - name: GF_AUTH_ANONYMOUS_ORG_ROLE
#           value: Admin
#         - name: GF_SERVER_ROOT_URL
#           # If you're only using the API Server proxy, set this value instead:
#           # value: /api/v1/proxy/namespaces/kube-system/services/monitoring-grafana/
#           value: /
#       volumes:
#       - name: grafana-storage
#         emptyDir: {}
# ---
# apiVersion: v1
# kind: Service
# metadata:
#   labels:
#     # For use as a Cluster add-on (https://github.com/kubernetes/kubernetes/tree/master/cluster/addons)
#     # If you are NOT using this as an addon, you should comment out this line.
#     kubernetes.io/cluster-service: 'true'
#     kubernetes.io/name: monitoring-grafana
#   name: monitoring-grafana
#   namespace: kube-system
# spec:
#   # In a production setup, we recommend accessing Grafana through an external Loadbalancer
#   # or through a public IP.
#   # type: LoadBalancer
#   # You could also use NodePort to expose the service at a randomly-generated port
#   type: NodePort
#   ports:
#   - port: 80
#     targetPort: 3000
#   selector:
#     k8s-app: grafana

# kubectl create -f heapster/deploy/kube-config/influxdb/
# kubectl create -f heapster/deploy/kube-config/rbac/heapster-rbac.yaml



