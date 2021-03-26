#!/bin/bash 

# Allow user supplied pre userdata code
${pre_userdata}

# For Weave CNI
rm -f /etc/cni/net.d/10-aws.conflist

# Bootstrap and join the cluster
/etc/eks/bootstrap.sh --b64-cluster-ca '${cluster_auth_base64}' --apiserver-endpoint '${endpoint}' ${bootstrap_extra_args} --kubelet-extra-args "${kubelet_extra_args}" '${cluster_name}'
