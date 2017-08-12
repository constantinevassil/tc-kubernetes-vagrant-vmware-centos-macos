# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  # Using a preconfigured static address: 192.168.0.199
  config.vm.network "public_network" , bridge: 'en0: Ethernet' #, ip: "192.168.0.199", netmask: "255.255.248.0"
  config.vm.provision :shell, path: "shared.sh"
  #config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.hostname = "tc-centos-master-hatc2"
 
   # port forwarding
  config.vm.network "forwarded_port", guest: 9200, host: 9201 # ES
  config.vm.network "forwarded_port", guest: 5601, host: 5602 # Kibana

  config.vm.provider "vmware_fusion" do |v|
      v.memory = 4096
      v.cpus = 2
      v.gui = true
      v.name = "tc-centos-master-hatc2"
      v.vmx["ethernet0.pcislotnumber"] = "32"
  	  v.vmx["ethernet1.pcislotnumber"] = "33"
    end
  
  # config.vm.synced_folder ".", "/vagrant2"


end


# vagrant up --provider vmware_fusion
