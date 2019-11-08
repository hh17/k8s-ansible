#!/bin/bash

source /etc/profile
kubectl create clusterrolebinding apiserver-kubelet-admin --user={{ca_username}} --clusterrole=system:kubelet-api-admin
