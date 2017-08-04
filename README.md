# tc-kubernetes-vagrant-vmware-centos-macos

Vagrant config with VMWare provider to run a full local Kubernetes cluster using the source directory from your Mac. No scripts. 

Step by step for full understing the process.

## Getting started

Topics:

1. Mac computer
1. VMWare Fusion 
1. Vagrant
1. Ubuntu 17.04+
1. kubeadm
1. Flannel
1. Create a deployment that manages a Pod
1. Scaling
1. Create a service
1. Access the service
1. Test the service
1. Update your app to version 2
1. Rollback your app to version 1
1. Rollback your app to version 2
1. Access your cluster from your local machine
1. Getting admin.conf from server and copy to your local machine
1. Dashboard
1. RBAC role
1. Access Dashboard On local machine
1. Access Service On local machine
1. Persistent storage
1. Golang example using hostPath
1. Installing Grafana

## Getting started

On Mac

```bash
xcode-select --install
git clone https://github.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos.git
cd tc-kubernetes-vagrant-vmware-centos-macos
```

# NOTE:  
1. Vagrantfile is using public static IP Address. Change to appropriate value.
config.vm.network "public_network" , bridge: 'en0: Ethernet' , ip: "192.168.0.199", netmask: "255.255.248.0"
1. bootstrap.sh is using this static IP Address to initialize Kubernetes. . Change to same as in Vagrantfile.
kubeadm init --apiserver-advertise-address 192.168.0.199 --pod-network-cidr 10.244.0.0/16 --token 8c2350.f55343444a6ffc46
1. Enabling shared folders with Vagrant’s VMware provider breaks Flannel network in Kubernetes. Weave network is used instead.

# You must have the following installed:

* VMware Fusion (Pro) >= 8.5
  
  https://www.vmware.com/products/fusion/fusion-evaluation.html
    
* Vagrant >= 1.9.7

  Download and install from https://www.vagrantup.com/.

  Vagrant + VMware
  
  Download and install from https://www.vagrantup.com/vmware/index.html
     
```bash
    vagrant plugin install vagrant-vmware-fusion
    vagrant plugin license vagrant-vmware-fusion ~/license.lic
```

* run Virtual machine (VM)

  Install by running: 
  
```bash
    vagrant up --provider vmware_fusion
```

## Enabling shared folders with Vagrant’s VMware provider

Updated CentOS Vagrant Images Available (v1707.01)
https://seven.centos.org/2017/08/updated-centos-vagrant-images-available-v1707-01/

Installing open-vm-tools is not enough for enabling shared folders with Vagrant’s VMware provider. Please follow the detailed instructions in https://github.com/mvermaes/centos-vmware-tools (updated for this release).


## Using kubeadm to create a cluster - single machine configuration. To schedule pods on master node.

Kubernetes is hard to install without using third party tools. kubeadm is an official tool for simple deployment. 

* Before you begin
	1.	One or more virtual machines running Ubuntu 17.04+
	1.	1GB or more of RAM per machine (any less will leave little room for your apps)
	1.	Full network connectivity between all machines in the cluster

* Objectives
	* Install a secure Kubernetes cluster on your machines
	* Install a pod network on the cluster so that application components (pods) can talk to each other
	* Install a sample Golang application on the cluster


```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  # Using a preconfigured static address: 192.168.0.199
  config.vm.network "public_network" , bridge: 'en0: Ethernet' , ip: "192.168.0.199", netmask: "255.255.248.0"
  # vagrant provision
  config.vm.provision :shell, path: "shared.sh"
  # config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.hostname = "tc-centos-master-hatc1"

  config.vm.provider "vmware_fusion" do |v|
      v.memory = 4096
      v.cpus = 2
      v.gui = true
      #v.vmx["ethernet0.pcislotnumber"] = "32"
      #v.vmx["ethernet1.pcislotnumber"] = "33"
    end

    #config.vm.synced_folder ".", "/vagrant2"

end

```

Uncomment:

  config.vm.provision :shell, path: "shared.sh"

Comment it out:

  config.vm.provision :shell, path: "bootstrap.sh"

Install shared folders

```bash
vagrant up --provider vmware_fusion
```

Uncomment:

 config.vm.synced_folder ".", "/vagrant2"

Comment it out:

  config.vm.provision :shell, path: "shared.sh"

Uncomment:

  config.vm.provision :shell, path: "bootstrap.sh"

Install Kubernetes:

```bash
vagrant provision
```

## Testing kubernetes from inside the master

### 1. Create a deployment that manages a Pod. 

deploy topconnector/tc-helloworld-go-ws

```bash
vagrant ssh master
vagrant@tc-k-vm-master:~$ kubectl run tc-helloworld-go-ws --image=topconnector/tc-helloworld-go-ws:v1 --port=8080 --record
```

Check rollout status:

```bash
vagrant@tc-k-vm-master:~$ kubectl rollout status deployment/tc-helloworld-go-ws
deployment "tc-helloworld-go-ws" successfully rolled out
```

View the Deployment:
```bash
vagrant@tc-k-vm-master:~$ kubectl get deployments
NAME                      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
tc-helloworld-go-ws          1         1         1            1           3m
```

View the Pods:

```bash
vagrant@tc-k-vm-master:~$ kubectl get pods -o wide
NAME                                       READY     STATUS    RESTARTS   AGE       IP           NODE
tc-helloworld-go-ws-495672996-nt1m9           1/1       Running   0          5m        10.244.1.4   master
```

### 2. Scaling:
```bash
vagrant@tc-k-vm-master:~$ kubectl scale --replicas=2 deployment/tc-helloworld-go-ws --record
deployment "tc-helloworld-go-ws" scaled
```

### 3. Create a service:
```bash
vagrant@tc-k-vm-master:~$ kubectl expose deployment tc-helloworld-go-ws --type=NodePort
service "tc-helloworld-go-ws" exposed
```
### 4. Access the service:

1. get node "master"'s IP address:
```bash
vagrant@tc-k-vm-master:~$ kubectl describe nodes

...
Addresses:
  InternalIP:	192.168.232.137
  Hostname:	master...  
```

IP address:192.168.44.10


2. get service port number

View the services:
```bash
vagrant@tc-k-vm-master:~$ kubectl get services
NAME                  CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
kubernetes            10.96.0.1       <none>        443/TCP          8m
tc-helloworld-go-ws   10.104.31.142   <nodes>       8080:30947/TCP   1m
```
service port number:32658 

### 5. Test the service:

The http address of the service: 192.168.232.137:30947

```bash
vagrant@tc-k-vm-master:~$ curl http://192.168.232.137:30947
Hello World from Go in minimal Docker container(4.28MB) v.1.0, it took 78ns to run
```

### 6. Update your app to version 2

```bash
vagrant@tc-k-vm-master:~$ kubectl set image deployment/tc-helloworld-go-ws tc-helloworld-go-ws=topconnector/tc-helloworld-go-ws:v2 --record
deployment "tc-helloworld-go-ws" image updated
vagrant@tc-k-vm-master:~$ curl http://192.168.232.137:30947
Hello World from Go in minimal Docker container(4.28MB) v.2.0, it took 68ns to run
```

### 7. Rollback your app to version 1

```bash
vagrant@tc-k-vm-master:~$ kubectl rollout undo deployment tc-helloworld-go-ws
deployment "tc-helloworld-go-ws" rolled back
vagrant@tc-k-vm-master:~$ curl http://192.168.232.137:30947
Hello World from Go in minimal Docker container(4.28MB) v.1.0, it took 68ns to run
```

### 8. Rollback your app to version 2

```bash
vagrant@tc-k-vm-master:~$ kubectl rollout undo deployment tc-helloworld-go-ws
deployment "tc-helloworld-go-ws" rolled back
vagrant@tc-k-vm-master:~$ curl http://192.168.232.137:30947
Hello World from Go in minimal Docker container(4.28MB) v.2.0, it took 68ns to run
```

## Access your cluster from your local machine

### 1. Get admin.conf from master

Get admin.conf from /etc/kubernetes on master and copy to your local machine's current folder:

```bash
vagrant@tc-k-vm-master:~$ sudo cat /etc/kubernetes/admin.conf > /vagrant2/admin.conf
exit
```

on your your local machine:

copy admin.conf to $HOME/.kube/config and prepare to use locally.

```bash
sudo mkdir -p $HOME/.kube
sudo cp -i ./admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo cat $HOME/.kube/config
```


### 2. Install and Set Up kubectl on your local machine

Now in order for you to actually access your cluster from your Mac you need kubectl locally.

Download the latest release with the command:

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl

Make the kubectl binary executable.

chmod +x ./kubectl

Move the binary in to your PATH.

sudo mv ./kubectl /usr/local/bin/kubectl

### 3. Check the master configuration 

Get nodes:

```bash
kubectl get nodes
AME      STATUS    AGE       VERSION
master    Ready     11h       v1.7.1
```
Get pods:

```bash
kubectl get pods
NAME                                   READY     STATUS    RESTARTS   AGE
tc-helloworld-go-ws-1724924830-gpf9c   1/1       Running   0          11h
tc-helloworld-go-ws-1724924830-wv4f1   1/1       Running   0          11h
```

Get services:

```bash
kubectl get services
NAME                  CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
kubernetes            10.96.0.1       <none>        443/TCP          11h
tc-helloworld-go-ws   10.105.98.177   <nodes>       8080:30947/TCP   11h
```
### On local machine

Run proxy to use dashboard locally:

```bash
kubectl proxy
```

Proxy should be listening on 127.0.0.1:8001. 

Point your browser to http://127.0.0.1:8001/ui

Access the service from local machine:

```bash
curl http://192.168.232.137:30947
```

Open Scope in Your Browser

```bash
kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
```

The URL is: 
http://localhost:4040

