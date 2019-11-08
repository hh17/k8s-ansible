# ansible for installing Kubernetes cluster


Kubernetes cluster version:

kubernetes 1.16

flanneld 1.11

docker  1.18


System: Centos 7.X


 How to use:


**ansible-playbook  playbooks/package/k8s.yml -e host=k8sall**



Points to note:

1: Modify the hosts list

Inventory/k8s.hosts


2: Modify key variables

Roles/package/k8s/vars/main.yml

``` 
Cfsmaster: 10.152.0.2
Nodes_ssl_path: /k8s/nodes/ssl
Nodes_path: /k8s/nodes
K8s_path: /k8s/kubernetes
Token: 201f9bd537b02cb8832c9efd7e7a1ff8
Cluster_iprange: '10.254.0.0/16'
Etcd_path: /k8s/etcd
Clusterdns: 10.254.0.10
Clusterdomain: 'cluster.local.'
Ca_username: k8s
Caexpiry: 87600

``` 



3: ansible version > 2.4





