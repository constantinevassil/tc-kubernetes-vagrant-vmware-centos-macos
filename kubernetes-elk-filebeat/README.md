# ELK stack on Kubernetes

In Kubernetes all logs are stored as files inside /var/log/containers, we can have an agent which will be deployed as DeamonSet and read those files from each worker and send them to Logstash.

```bash
sudo kubectl apply --filename kubefiles/elasticsearch-deployment.yaml
sudo kubectl apply --filename kubefiles/elasticsearch-service.yaml
```
