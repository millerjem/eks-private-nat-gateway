## Addressing IPv4 address Exhaustion in Amazon EKS Clusters using private NAT gateways

This repository contains software artifacts for implementing the networking architecture discussed in this [blog](https://aws.amazon.com/blogs/containers/addressing-ipv4-address-exhaustion-in-amazon-eks-clusters-using-private-nat-gateways/) to deploy Amazon EKS clusters into VPCs wth overlapping CIDRs. It demonstrates a use case where workloads deployed in an EKS cluster provisioned in a VPC are made to communicate, using a private NAT gateway, with workloads deployed to another EKS cluster in a different VPC with overlapping CIDR ranges. 

### Network architecture
<img class="wp-image-1960 size-full" src="images/network-architecture.png" alt="Network architecture"/>

### Solution architecture
<img class="wp-image-1960 size-full" src="images/solution-architecture.png" alt="Solution architecture"/>

### Deployment Instructions

#### Setting up the network architecture
1. Execute the script **vpc-a.sh** to setup a VPC named **EKS-VPC-A** with the routable CIDR 192.168.16.0/20 and non-routable CIDR 100.64.0.0/16
2. Execute the script **vpc-b.sh** to setup a VPC named **EKS-VPC-B** with the routable CIDR 192.168.32.0/20 and non-routable CIDR 100.64.0.0/16
3. Execute the script **vpc-b.sh** to setup a VPC named **EKS-VPC-C** with the routable CIDR 192.168.48.0/20 and non-routable CIDR 100.64.0.0/16
4. Execute the script **tgw.sh** to setup a transit gateway and transit gateway attachments in order to route traffic between the two VPCs. This script will also update the route tables associated with the transit gateway as well as the routable subnets in the two VPCs.

 
#### Setting up the EKS clusters 
5. Execute the script **cluster-a.sh** to launch an EKS cluster named **EKS-CLUSTER-A** into **EKS-VPC-A** and provision a managed node group.
6. Execute the script **cluster-b.sh** to launch an EKS cluster named **EKS-CLUSTER-B** into **EKS-VPC-B** and provision a managed node group.
7. Execute the script **cluster-c.sh** to launch an EKS cluster named **EKS-CLUSTER-C** into **EKS-VPC-C** and provision a managed node group.
8. Run the *aws eks update-kubeconfig --name $CLUSTER_NAME --region $REGION* command to update the Kubernetes configuration file and enable *kubectl* 
access to the clusters.

#### Deploying workloads to the EKS clusters 
9. Execute the script **createIRSA.sh** to set IAM roles and service accounts required to deploy the AWS Load Balancer Controller to both clusters.
10. Set Kubernetes context to **EKS-CLUSTER-A** and then execute the script **kubernetes-deploy-a.sh**. This will deploy the AWS Load Balancer controller to the cluster.
11. Set Kubernetes context to **EKS-CLUSTER-B** and then execute the script **kubernetes-deploy-b.sh**. This will deploy the AWS Load Balancer controller to the cluster.
12. Set Kubernetes context to **EKS-CLUSTER-C** and then execute the script **kubernetes-deploy-C.sh**. This will deploy the AWS Load Balancer controller to the cluster.

#### Cleanup
Please use the following scripts to cleanup the resources provisioned above.
- Delete the transit gateway using [cleanup-tgw.sh](https://github.com/aws-samples/eks-private-nat-gateway/blob/main/cleanup-tgw.sh)
- Delete the EKS clusters using [cleanup-cluster.sh](https://github.com/aws-samples/eks-private-nat-gateway/blob/main/cleanup-cluster.sh)
- Delete the VPCs using [cleanup-vpc.sh](https://github.com/aws-samples/eks-private-nat-gateway/blob/main/cleanup-vpc.sh)

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.


