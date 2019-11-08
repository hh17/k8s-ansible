
#!/bin/bash
#创建kubelet bootstrapping kubeconfig 
BOOTSTRAP_TOKEN={{token}}
KUBE_APISERVER="https://{{cfsmaster}}:6443"
NODES_SSL_PATH="{{nodes_ssl_path}}"
#设置集群参数
kubectl config set-cluster kubernetes \
  --certificate-authority=${NODES_SSL_PATH}/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=bootstrap.kubeconfig
 
#设置客户端认证参数
kubectl config set-credentials kubelet-bootstrap \
  --token=${BOOTSTRAP_TOKEN} \
  --kubeconfig=bootstrap.kubeconfig
 
# 设置上下文参数
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kubelet-bootstrap \
  --kubeconfig=bootstrap.kubeconfig
 
# 设置默认上下文
kubectl config use-context default --kubeconfig=bootstrap.kubeconfig
 
#----------------------
 
# 创建kube-proxy kubeconfig文件
 
kubectl config set-cluster kubernetes \
  --certificate-authority=${NODES_SSL_PATH}/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=kube-proxy.kubeconfig
 
kubectl config set-credentials kube-proxy \
  --client-certificate=${NODES_SSL_PATH}/kube-proxy.pem \
  --client-key=${NODES_SSL_PATH}/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=kube-proxy.kubeconfig
 
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kube-proxy \
  --kubeconfig=kube-proxy.kubeconfig
 
kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig


