#!/usr/bin/env bash

# su --> password = 'vagrant'
# vagrant rsync
sudo yum -y update

sudo yum -y install open-vm-tools
sudo yum -y install perl gcc fuse make kernel-devel net-tools policycoreutils-python
mkdir -p /tmp/vmware /tmp/vmware-archive
sudo mount -o loop /vagrant/linux.iso /tmp/vmware
TOOLS_PATH="`ls /tmp/vmware/VMwareTools-*.tar.gz`"
tar xzf ${TOOLS_PATH} -C /tmp/vmware-archive
sudo /tmp/vmware-archive/vmware-tools-distrib/vmware-install.pl --force-install --default
sudo umount /tmp/vmware
rm -rf /tmp/vmware /tmp/vmware-archive /vagrant/*.iso
