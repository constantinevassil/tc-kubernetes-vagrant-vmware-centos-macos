
```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/0-namespace.yaml
```

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/elasticsearch-deployment.yaml
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/elasticsearch-service.yaml
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/elasticsearch-configmap.yaml
```

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/kibana-deployment.yaml
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/kibana-service.yaml
```
