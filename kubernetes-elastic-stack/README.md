### 0-namespace.yaml

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/0-namespace.yaml
```

### elasticsearch-configmap.yaml

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/elasticsearch-configmap.yaml
```

### elasticsearch-deployment.yaml

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/elasticsearch-deployment.yaml
```

### elasticsearch-service.yaml

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/elasticsearch-service.yaml
```

```bash
ip addr
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:0c:29:12:70:3a brd ff:ff:ff:ff:ff:ff
    inet 10.0.1.67/24 brd 10.0.1.255 scope global dynamic eth1
       valid_lft 75041sec preferred_lft 75041sec
    inet6 fe80::20c:29ff:fe12:703a/64 scope link
       valid_lft forever preferred_lft forever
       
kubectl get svc
NAME            CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
elasticsearch   10.98.175.174   <nodes>       9200:32056/TCP   2m
kubernetes      10.96.0.1       <none>        443/TCP          3h

curl -XGET '10.0.1.67:32056/?pretty'
```


### kibana-configmap.yaml

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/kibana-configmap.yaml
```

### kibana-deployment.yaml

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/kibana-deployment.yaml
```

### kibana-service.yaml

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/kibana-service.yaml
```

### get pods

```bash
kubectl get pods --all-namespaces
```



