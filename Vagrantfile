# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  # Using a preconfigured static address: 192.168.0.199
  config.vm.network "public_network" , bridge: 'en0: Ethernet' , ip: "192.168.0.199", netmask: "255.255.248.0"
  config.vm.provision :shell, path: "bootstrap.sh"

  config.vm.provider "vmware_fusion" do |v|
      v.memory = 2048
      v.cpus = 2
      v.gui = true
      #v.vmx["ethernet0.pcislotnumber"] = "32"
 	    #v.vmx["ethernet1.pcislotnumber"] = "33"
    end

# config.ssh.username = 'root'
# config.ssh.password = 'vagrant'
# config.ssh.insert_key = 'true'

end


# vagrant up --provider vmware_fusion
