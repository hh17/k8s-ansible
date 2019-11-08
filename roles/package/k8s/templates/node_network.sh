#!/bin/bash
{%- set etccluster=[] %}
{%- for i in groups['etcd']  -%}
{{ etccluster.append("https://"+i+":2379") }}
{% endfor -%}
source /etc/profile
etcd_path="{{etcd_path}}"

etcdctl --ca-file=${etcd_path}/ssl/ca.pem \
    --cert-file=${etcd_path}/ssl/k8s.pem  \
    --key-file=${etcd_path}/ssl/k8s-key.pem \
    --endpoints="{{etccluster|join(',')}}"  \
    set /k8s/network/config  '{ "Network": "{{cluster_iprange}}", "Backend": {"Type": "vxlan"}}' 


if [ ` kubectl get  clusterrolebinding|grep kubelet-bootstrap -c` -eq 0 ];then
kubectl create clusterrolebinding kubelet-bootstrap \
      --clusterrole=system:node-bootstrapper \
        --user=kubelet-bootstrap
fi

if [ ` kubectl get  clusterrolebinding|grep apiserver-kubelet-admin -c` -eq 0 ];then
kubectl create clusterrolebinding apiserver-kubelet-admin \
    --user={{ca_username}} \
    --clusterrole=system:kubelet-api-admin
fi
