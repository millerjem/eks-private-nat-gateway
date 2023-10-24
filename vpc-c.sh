##!/bin/bash

REGION=us-west-2
VPC_TEMPLATE=eks-vpc-stack.yaml
VPC_STACK_NAME="eks-vpc-c-stack"
VPC_NAME="EKS-VPC-C"
ROUTABLE_CIDR1="192.168.48.0/20"
ROUTABLE_CIDR2="192.168.16.0/20"
ROUTABLE_CIDR3="192.168.32.0/20"
PUBLIC_ROUTABLE_SUBNET1_CIDR="192.168.48.0/24"
PUBLIC_ROUTABLE_SUBNET2_CIDR="192.168.49.0/24"
PRIVATE_ROUTABLE_SUBNET1_CIDR="192.168.50.0/24"
PRIVATE_ROUTABLE_SUBNET2_CIDR="192.168.51.0/24"

aws cloudformation deploy --stack-name $VPC_STACK_NAME --template-file $VPC_TEMPLATE --parameter-overrides \
VpcName=$VPC_NAME \
VpcBlock=$ROUTABLE_CIDR1 \
PeerVpcBlock01=$ROUTABLE_CIDR2 \
PeerVpcBlock02=$ROUTABLE_CIDR3 \
Subnet01Block=$PUBLIC_ROUTABLE_SUBNET1_CIDR \
Subnet02Block=$PUBLIC_ROUTABLE_SUBNET2_CIDR \
Subnet01PrivateBlock=$PRIVATE_ROUTABLE_SUBNET1_CIDR \
Subnet02PrivateBlock=$PRIVATE_ROUTABLE_SUBNET2_CIDR \
--capabilities CAPABILITY_IAM --region $REGION