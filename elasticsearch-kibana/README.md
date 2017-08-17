# Services modified to NodePort type

## es-statefulset

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elasticsearch-kibana/es-statefulset.yaml
```

## es-service

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elasticsearch-kibana/es-service.yaml
```

## kibana-deployment

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elasticsearch-kibana/kibana-deployment.yaml
```

## kibana-service

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elasticsearch-kibana/kibana-service.yaml
```

