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

```bash
[vagrant@tc-centos-master-hatc2 vagrant2]$ kubectl describe nodes
...
Addresses:
  InternalIP:	192.168.0.199
  Hostname:	tc-centos-master-hatc2
...
```
Node IP: 192.168.0.199

Service Port:32708

```bash
[vagrant@tc-centos-master-hatc2 vagrant2]$ curl 192.168.0.199:32708
{
  "name" : "elasticsearch-logging-1",
  "cluster_name" : "kubernetes-logging",
  "cluster_uuid" : "LEV0A5EmT66_XBPrhtQXhg",
  "version" : {
    "number" : "5.5.1",
    "build_hash" : "19c13d0",
    "build_date" : "2017-07-18T20:44:24.823Z",
    "build_snapshot" : false,
    "lucene_version" : "6.6.0"
  },
  "tagline" : "You Know, for Search"
}
```

## kibana-deployment

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elasticsearch-kibana/kibana-deployment.yaml
```

## kibana-service

```bash
sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elasticsearch-kibana/kibana-service.yaml
```

```bash
[vagrant@tc-centos-master-hatc2 ~]$ kubectl get svc --all-namespaces
NAMESPACE     NAME                    CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
default       kubernetes              10.96.0.1        <none>        443/TCP          6h
kube-system   elasticsearch-logging   10.103.188.191   <nodes>       9200:32168/TCP   6h
kube-system   heapster                10.100.137.219   <none>        80/TCP           6h
kube-system   kibana-logging          10.98.145.221    <nodes>       5601:31173/TCP   43s
kube-system   kube-dns                10.96.0.10       <none>        53/UDP,53/TCP    6h
kube-system   kubernetes-dashboard    10.101.68.91     <none>        80/TCP           6h
kube-system   monitoring-grafana      10.104.94.79     <nodes>       80:32354/TCP     6h
kube-system   monitoring-influxdb     10.102.173.136   <none>        8086/TCP         6h
kube-system   weave-scope-app         10.110.64.204    <none>        80/TCP           6h
```

Node IP: 192.168.0.199

Service Port:31173

```bash
curl 192.168.0.199:31173
<script>var hashRoute = '/app/kibana';
var defaultRoute = '/app/kibana';

var hash = window.location.hash;
if (hash.length) {
  window.location = hashRoute + hash;
} else {
  window.location = defaultRoute;
```
  
