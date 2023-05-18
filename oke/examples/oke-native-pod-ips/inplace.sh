#!/usr/bin/bash


nodepoolids=$(kubectl get nodes -o yaml | grep -i node-pool-id | sort | uniq | awk '{ print $2}')

oldnodes=$(kubectl get nodes | grep v1.24 | awk '{ print $1}')

echo "Nodes with old k8s version: "
echo "----------------------------"
echo "$oldnodes"

newnodes=$(kubectl get nodes --no-headers | grep -v v1.24 | awk '{ print $1}')

echo "Nodes with new k8s version: "
echo "----------------------------"
echo "$newnodes"

for n in $oldnodes
do
        echo "Draining node $n"
        echo "----------------"
        kubectl drain $n --ignore-daemonsets --delete-emptydir-data
done


for m in $oldnodes
do
        node_ocid=""
        nodepool_ocid=""
        node_ocid=$( kubectl describe node $m | grep ProviderID: | awk '{ print $2 }')
        nodepool_ocid=$(kubectl describe node $m | grep "oci.oraclecloud.com\/node-pool-id:" | awk '{ print $NF }')
        echo "Deleting node $m which is running on version 1.24 ..."
        oci ce node-pool delete-node --node-pool-id $nodepool_ocid --node-id $node_ocid --force
        if [[ $? = 0 ]]; then
                echo "Node $m deleted successfully. Please note it might take sometime for the node to get deleted from the cluster"
        else
                echo "Unable to delete $m. Please try again later"
        fi
done


while true
do
        if kubectl get nodes |grep v1.24 1> /dev/null; then
                echo "Old Nodes are still getting deleted ..."
        else
                echo "All nodes running the older k8s version are deleted. "
                exit 0
                break; 
        fi
done
