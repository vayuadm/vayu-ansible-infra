##### Running Elasticsearch using docker:
```bash
sudo sysctl -w vm.max_map_count=262144
sudo docker run  -d -v $PWD/roles/k8s/tasks/elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -e "http.host=0.0.0.0" -e "network.host=0.0.0.0" -p 9200:9200 -p 9300:9300 --name es --ulimit memlock=-1:-1 docker.elastic.co/elasticsearch/elasticsearch:5.2.2
```
