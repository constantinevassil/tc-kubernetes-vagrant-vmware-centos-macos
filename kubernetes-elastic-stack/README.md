sudo kubectl apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/elasticsearch-deployment.yaml
sudo apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/elasticsearch-service.yaml
sudo apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/elasticsearch-configmap.yaml

sudo apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/kibana-deployment.yaml
sudo apply --filename https://raw.githubusercontent.com/topconnector/tc-kubernetes-vagrant-vmware-centos-macos/master/kubernetes-elastic-stack/kibana-service.yaml

