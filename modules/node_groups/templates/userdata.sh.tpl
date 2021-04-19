#!/bin/bash -e

# Uncomment for Weave CNI
# rm -f /etc/cni/net.d/10-aws.conflist

# Allow user supplied pre userdata code
${pre_userdata}

/etc/eks/bootstrap.sh --b64-cluster-ca '${cluster_auth_base64}' --apiserver-endpoint '${cluster_endpoint}' ${bootstrap_extra_args} --kubelet-extra-args "${kubelet_extra_args}" '${cluster_name}'
