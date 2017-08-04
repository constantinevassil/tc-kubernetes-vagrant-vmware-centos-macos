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

