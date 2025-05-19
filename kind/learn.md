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
10. to get system presistent volume we need to create a `yml` file. in this file if we specify the namespace then volume bound for this namespace only so it is good to not specify it.

#### Example Project. 
* First create docker image of project. 
* Then we need to publish it somewhere, i.e. DockerHub or (ig. AWS Container Registry.)
* After this create `mkdir k8s` for kubernetes.
* In this `k8s` dir create files require for k8s i.e. `deployment.yml`, `service.yml`, `namespace.yml` and more...
* Then finally do appy using command: `kubectl apply -f {fileName}.yml`, do  not forget to port-forwarding if needed.

11. **Ingress**: it is a traffic re router in k8s. [ a resource that manages external access to services within a cluster, typically for HTTP and HTTPS traffic.] It provides a single entry point into the cluster, simplifying the management of applications and troubleshooting routing issues
12. we need to download **ingress conroller** to use ingress. it is available on KIND web platform. after all setiing up we need to expose ingress to public at some port i.e. 8080.
13. **get more info on `ingress Annotaion`. web search or YT on anywhere**

#### statefullSet

14. stateFull sets are used when we have stateFull applications like MySql or MongoDB. 
15. they are same a replicaset but in addtion they meintain number is pods i.e.1,2,3,4... when a pod get fails then it will **create new pod and assign to same numbered pod which failed and it trasfer the entire state to new pod.** 
16. everthing in statefulSet in defined in yml only i.e. service, volumes and more...
17. a service which have `clusterIP = None`  is called headless service i.e. we don't want to expose it to public.

> Mysql Saviour Command: `ln -s /var/lib/mysql/mysql.sock /var/run/mysqld/mysqld.sock` for Error `ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)` 

> Question: diff in deployment / replicaSet / statefulSet.

#### configMap and secrets
18. configMap is one kind os enc file for k8s. we are storing value like `MYSQL_DATABSE` so we no need to change in statefulSet file instead we can make change in map file.
19. secret file... well don't go on name of the file, coz this file is use jsut for computer binay coded purpose. **this file won't serve as security purpose** anyone can easy do `base64` encode/decode.


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

> persistent volumes

`kubectl get pv`
`kubectl get pv -n name-of-namespace`

> port forwarding

```bash 
    kubectl port-forward service/nginx-service -n ns4-nginx 81:80 --address=0.0.0.0
    # if not works then try with sudo
    sudo -E kubectl port-forward service/nginx-service -n ns4-nginx 81:80 --address=0.0.0.0
    # use -E , it will create a environment.
```

> Ingress 

`kubectl get ing -n name-of-namespace`
`kubectl get configmap -n name-of-namespace`
`kubectl get secret -n name-of-namespace`


<hr>

> 1. what is kubectl ?
> 2. after rolling update we chagene version so containers change ok. so i that case what about older containre data and is it still there or auto removed/deted ?
> 3. i have a persistent volume of 2 GB in available state, so in this case does system can use this too or is it special for k8s cluster/containers

### kind

`kind verison`
`kind create cluster --name=name-of-cluster --config=config.yml`

<hr>

> what is kind?
> why kind?

Time stamp: 2:21:28