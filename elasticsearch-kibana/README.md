# Services modified to NodePort type

## es-statefulset

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/fluentd-elasticsearch/es-statefulset.yaml
```

## es-service

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/fluentd-elasticsearch/es-service.yaml
```

## kibana-deployment

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/fluentd-elasticsearch/kibana-deployment.yaml
```

## kibana-service

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/fluentd-elasticsearch/kibana-service.yaml
```

## fluentd-es-configmap

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/fluentd-elasticsearch/fluentd-es-configmap.yaml
```

## fluentd-es-ds

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/fluentd-elasticsearch/fluentd-es-ds.yaml
```

