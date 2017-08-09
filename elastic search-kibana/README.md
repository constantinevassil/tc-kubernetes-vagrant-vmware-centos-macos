
## Deploy

```bash
kubectl create -f https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elastic%20search-kibana/es-discovery-svc.yaml
kubectl create -f https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elastic%20search-kibana/es-svc.yaml
kubectl create -f https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/elastic%20search-kibana/es-master.yaml
```

```bash
kubectl get svc,deployment,pods
NAME                          CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
svc/elasticsearch             10.105.81.24    <pending>     9200:30962/TCP   43s
svc/elasticsearch-discovery   10.110.75.230   <none>        9300/TCP         50s
svc/kubernetes                10.96.0.1       <none>        443/TCP          6m

NAME               DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deploy/es-master   1         1         1            0           35s

NAME                           READY     STATUS    RESTARTS   AGE
po/es-master-298393659-zk7s4   1/1       Running   0          35s
Constantines-iMac:tc-kubernetes-vagrant-vmware-centos-macos constantinevas$ kubectl get svc,deployment,pods
NAME                          CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
svc/elasticsearch             10.105.81.24    <pending>     9200:30962/TCP   1m
svc/elasticsearch-discovery   10.110.75.230   <none>        9300/TCP         1m
svc/kubernetes                10.96.0.1       <none>        443/TCP          6m

NAME               DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deploy/es-master   1         1         1            1           53s

NAME                           READY     STATUS    RESTARTS   AGE
po/es-master-298393659-zk7s4   1/1       Running   0          53s
```

```bash
kubectl logs po/es-master-298393659-zk7s4
```

```bash
kubectl get svc elasticsearch
```

