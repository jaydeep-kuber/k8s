1. learn architecture of kubernets.
2. ways to create clusters
    i.  minikube
    ii. kind
    iii.kubeadm
    iv. EKS/AKS
3. setup: kind + kubectl in linux
4. how thing going on ?
    namespace [ docker container > pod > deployment > service > users ]
    * namespace user to isolate service, these are like groups of resources.
5. Created `.yml` file for namespace, pod and deployment. these **ymls are case sensitive**.
6. To make pods scalable we need `deployment.yml`
7. For scalig we need replicas of pods sp there are 3 ways to make replicas.
    i.   ReplicaSet: a group of multiple instances of the same Pod like have same image.
    ii.  StatefulSet: It manages the deployment and scaling of a set of Pods and provides guarantees about the ordering and uniqueness of these Pods
    iii. Deployment: work same ar replicaset but provide additional feature of rolling update.
    iv. DaemonSet: eansure that on each node at least one replica is runnig.
8. Replication controller: it manages raplicas of pods. pos cloning. controls replicas 
9. Jobs and cronJobs

## COMMANDS wih QUESTIONS

### kubectl
`kubectl verison`
`kubectl get nodes`
``` bash
    kubectl get namespace
    # or 
    kubectl get ns
```
`kubectl cluster-info --context=kind-name-of-cluster`
`kubectl get pods`
`kubectl get pods -n name-of-namespace`

> to get more info on pods.

`kubectl get pods -n name-ofnamespace -o wide` 
`kubectl create ns name-of-namespace`
`kubectl run nginx --image=nginx`
`kubectl run nginx --image=nginx -n name-of-namespace`
`kubectl delete pod nginx`
`kubectl delete pod nginx -n name-of-namespace`
`kubectl delete ns name-of-namespace`
`kubectl apply -f yml-file-name`
> we are using apply because apply do both create and update but create do only creation.

`kubectl exec -it pods/name-of-pod -n name-of-namespace -- bash`
> nake sure use a space between `-- bash`

`kubectl describe pod/name-of-pod -n name-of-namespace`
> deployment

`kubectl get deployment -n name-of-namespace`
`kubectl scale deployment/name-of-deployment -n name-of-namespace --replicas=5`
>> rolling updates

`kubectl set image deployment/name-of-deployment -n name-of-namespace name-of-container=name-of-image:tag/version`
`kubectl get job -n name-of-namespace`
`kubectl logs pods/name-of-pod -n name-of-namespace`

<hr>

> 1. what is kubectl ?
> 2. after rolling update we chagene version so containers change ok. so i that case what about older containre data and is it still there or auto removed/deted ?


### kind

`kind verison`
`kind create cluster --name=name-of-cluster --config=config.yml`

<hr>

> what is kind?
> why kind?

Time stamp: 2:21:28