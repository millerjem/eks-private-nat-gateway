
##!/bin/bash

#
# Set Kubernetes context to cluster B using 'kubectl config use-context' before running these commands
#

#
# Deploy the AWS load balancer controller
#
CLUSTER_NAME="EKS-CLUSTER-B"
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system \
--set clusterName=$CLUSTER_NAME \
--set serviceAccount.create=false \
--set serviceAccount.name=aws-load-balancer-controller

#
# Deploy services
# This will provision an internal NLB
#
## /!\ WARNING /!\
## values below will only work with the "AWS Load Balancer Controller". Not with the default k8s in-tree controller
# service.beta.kubernetes.io/aws-load-balancer-type: "external" # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/guide/service/nlb/#configuration
# service.beta.kubernetes.io/aws-load-balancer-scheme: internal # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/guide/service/nlb/
# service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: "instance" # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/guide/service/nlb/#instance-mode_1
