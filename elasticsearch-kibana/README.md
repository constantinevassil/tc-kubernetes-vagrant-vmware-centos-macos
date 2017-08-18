# Services modified to NodePort type

## es-statefulset

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elasticsearch-kibana/es-statefulset.yaml
```

```bash
[vagrant@tc-centos-master-hatc2 vagrant2]$ kubectl get pods --all-namespaces
[vagrant@tc-centos-master-hatc2 vagrant2]$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                             READY     STATUS    RESTARTS   AGE
kube-system   elasticsearch-logging-0                          1/1       Running   0          1m
kube-system   elasticsearch-logging-1                          1/1       Running   0          33s
kube-system   etcd-tc-centos-master-hatc2                      1/1       Running   0          13d
kube-system   heapster-84017538-wf5x7                          1/1       Running   0          13d
kube-system   kube-apiserver-tc-centos-master-hatc2            1/1       Running   0          13d
kube-system   kube-controller-manager-tc-centos-master-hatc2   1/1       Running   0          13d
kube-system   kube-dns-2425271678-hfxv8                        3/3       Running   0          13d
kube-system   kube-proxy-w6tkm                                 1/1       Running   0          13d
kube-system   kube-scheduler-tc-centos-master-hatc2            1/1       Running   0          13d
kube-system   kubernetes-dashboard-3313488171-dzwp6            1/1       Running   0          13d
kube-system   monitoring-grafana-1500490092-1dhqz              1/1       Running   0          13d
kube-system   monitoring-influxdb-1870447071-sxct3             1/1       Running   0          13d
kube-system   weave-net-gdbwd                                  2/2       Running   0          13d
kube-system   weave-scope-agent-fcwmg                          1/1       Running   0          13d
kube-system   weave-scope-app-2536107919-tcbmc                 1/1       Running   0          13d
```

## es-service

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elasticsearch-kibana/es-service.yaml
```

```bash
[vagrant@tc-centos-master-hatc2 vagrant2]$ kubectl get svc --all-namespaces
NAMESPACE     NAME                    CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
default       kubernetes              10.96.0.1        <none>        443/TCP          13d
kube-system   elasticsearch-logging   10.109.121.45    <nodes>       9200:32708/TCP   12s
kube-system   heapster                10.109.144.228   <none>        80/TCP           13d
kube-system   kube-dns                10.96.0.10       <none>        53/UDP,53/TCP    13d
kube-system   kubernetes-dashboard    10.97.176.22     <none>        80/TCP           13d
kube-system   monitoring-grafana      10.105.154.143   <nodes>       80:31045/TCP     13d
kube-system   monitoring-influxdb     10.103.99.69     <none>        8086/TCP         13d
kube-system   weave-scope-app         10.107.82.4      <none>        80/TCP           13d
```

## kibana-deployment

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elasticsearch-kibana/kibana-deployment.yaml
```

## kibana-service

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elasticsearch-kibana/kibana-service.yaml
```

