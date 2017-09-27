

To create the deployment execute:

```bash
kubectl create -f https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/jenkins/jenkins-deployment.yaml 
```

To validate that creating the deployment was successful you can invoke:

```bash
kubectl get deployments
```

```bash
kubectl create -f jenkins-service.yaml
```
