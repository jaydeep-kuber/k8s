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


#### scaling and scheduling
* **resourse quota**
- Req and Req quotas helps to define which pod can take how much resourse on a machine. i.e. storage,ram and more...
- you need to define res -> reqs and limits there you will define CPU and Memory and more...

* **Probs**
- Tyes of prob:
    1. liveness prob
    2. readiness prob 
    3. startup prob
- prob is the request for checking whether your app is workning or not nothing else.

#### Taints / Tolerations
* Taint: it is a way to tell scheduler "hey!! you are not allowed to create pods on a perticular node"
* Tolerans: by using it you can **still create pods on tainted node**. find command at command section.

#### HPA: Horizontal Pod Autoscaling 
* you  are increasing replicas of the pod like current you have 2 but while scaling you make it 4 or 5...
#### VPA: Vertical Pod Autoscaling
* you are increasing resourses of a single pod, like CPU,Memory and more... make pod more powerful.
#### KEDA: Kubernetes Event Driven Autoscaling
* KEDA will select HPA/VPA base on `metrics` readings.

* #### Metrics
- Get metrics for KIND: `kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`
- yes you can apply `.yml` from a git repo too it will work fine.
- you need to bypass the security defences so edit deployment file. 

`kubectl -n kube-system edit deployment metrics-server` 
- Add the security bypass to deployment under `container.args`

```yml
- --kubelet-insecure-tls
- --kubelet-preferred-address-types=InternalIP,Hostname,ExternalIP
```

- restart deployment: `kubectl -n kube-system rollout restart deployment metrics-server` and do veriyfication 

#### apache
- **Note:** `http://<service-name>.<namepace>.svc.cluster.local` is the domain name inside a pod you can do `curl` on this domain. e.x : `curl http://apache-service.apache.svc.cluster.local` this is domain for service `apache-service` and `apache` namespace. it works only inside a pod not for external usage. 


#### Node affinity
- a mechanism that allows you to specify rules for pod scheduling based on node labels.providing more control over where pods are placed in a cluster 
- Affinity is some kind of like actions which performed to attract someone to something. e.x. if you want to create a pod on a node then specidy node infomation to pod so it can attract twards node.


#### RBAC : Role Based Access Control
* Before RBAC we have to know about, serive account and user account
- - service account are on level of namespaces
    |- for that we need to know **roles and role bindings**
- - user account are usually on level of cluster.
    |- for that we need to know **cluster role and cluster role bindings**

#### Dashbosrd
- 

#### Custome resouece defination (CRDs)
- CRDs are used to define own custom resources that can be used in Kubernetes. i.e. kind:jkGroups, apiVersion: v1, name: mygroup, spec: {}

#### HELM
- HELM is a package manager for Kubernetes. it is used to install and manage applications on Kubernetes.


#### Side car container / init container.
1. self explainetory init is a container which do initilization work like prereqs fullfilment. 
2. sidecare container is a like having assistent for main, ex. log container for main apk.

#### Service Mesh
- Service mesh gives a gateway for managing service communication and routing.
- popular tool for manage service mesh is **istio**

## COMMANDS wih QUESTIONS

### kubectl
```bash
    kubectl verison
    kubectl get nodes
```
``` bash
    kubectl get namespace
    # or 
    kubectl get ns
```
```bash
    kubectl cluster-info --context=kind-{name-of-cluster}
    kubectl get pods
    kubectl get pods -n name-of-namespace
```

> to get more info on pods.

```bash
    kubectl get pods -n name-ofnamespace -o wide 
    kubectl create ns name-of-namespace
    kubectl run nginx --image=nginx
    kubectl run nginx --image=nginx -n name-of-namespace
    kubectl run -it load-generator --image=busybox -n apache -- bash
    kubectl delete pod nginx
    kubectl delete pod nginx -n name-of-namespace
    kubectl delete ns name-of-namespace
    kubectl apply -f yml-file-name
```
> we are using apply because apply do both create and update but create do only creation.

`kubectl exec -it pods/name-of-pod -n name-of-namespace -- bash`

> nake sure use a space between `-- bash`

`kubectl describe pod/name-of-pod -n name-of-namespace`

> deployment
```bash
    kubectl get deployment -n name-of-namespace
    kubectl scale deployment/name-of-deployment -n name-of-namespace --replicas=5
```
> rolling updates
```bash
    kubectl set image deployment/name-of-deployment -n name-of-namespace name-of-container=name-of-image:tag/version
    kubectl get job -n name-of-namespace
    kubectl logs pods/name-of-pod -n name-of-namespace
```
> persistent volumes

```bash
    kubectl get pv
    kubectl get pv -n name-of-namespace
```
> port forwarding

```bash 
    kubectl port-forward service/nginx-service -n ns4-nginx 81:80 --address=0.0.0.0
    # if not works then try with sudo
    sudo -E kubectl port-forward service/nginx-service -n ns4-nginx 81:80 --address=0.0.0.0
    # use -E , it will create a environment.
```

> Ingress 

```bash
    kubectl get ing -n name-of-namespace
    kubectl get configmap -n name-of-namespace
    kubectl get secret -n name-of-namespace
```

> Taint
```bash
    kubectl taint node name-of-node prod=true:NoSchedule
    kubectl taint node name-of-node prod=true:NoSchedule-
```
> get info of cuurent user
```bash
    kuberctl auth whoami
    kubectl auth can-i get pods
    kubectl auth can-i get pods -n name-of-namespace
    kubectl auth can-i get pods -n name-of-namespace --as=user_name
    kubectl get role -n name-of-namespace
    kubectl get serviceaccount -n name-of-namespace
    kubectl get rolebinding -n name-of-namespace
```

> create token

`kubectl -n kubernetes-dashboard create token admin-user`

> get custom res defination
```bash
    kubectl apply -f custom-resource-definition.yaml
    kubectl get crd
    kubectl describe {crd-name} {cr}
```
> HELM

```bash
    helm create {apache-helm}
    helm package {apache-helm-path}
    helm install {apache-helm-name} {apache-helmPack-path}
    helm install {apache-helm-name} {apache-helmPack-path} -n {apache-namespase} --create-namespace
    helm upgrade {apache-helm-name} {apache-helmPack-path} -n {apache-namespase}
    helm rollback {apache-namespace} 1 -n prd-apache
    helm uninstall {apache-helm-name}
    helm search repo {repo-name}
    helm repo add {repo-name} {repo-url}
    helm list -n {namespace-name}
```

<hr>

> 1. what is kubectl ?
> 2. after rolling update we chagene version so containers change ok. so i that case what about older containre data and is it still there or auto removed/deted ?
> 3. i have a persistent volume of 2 GB in available state, so in this case does system can use this too or is it special for k8s cluster/containers

### kind
```bash
    kind verison
    kind create cluster --name=name-of-cluster --config=config.yml
```
<hr>

> what is kind?
> why kind?

<hr>

## Project-1 Chat Apllication on k8s - 3 Tier [ **Minikube** ]
- Frontend: React
- Backend: node
- Database: mongoDB

> [github_Link](https://github.com/iemafzalhassan/full-stack_chatApp.git)

- start the minkube
```bash
    minicube start --driver=docker
    # install minikube, if you don't have it
```

- To create pod we need to have image on docker hub. so create images of backend and frontend and push them in docker for mongoDB we will pick image from docker hub.
- Create a directory named **k8s** in same project working directory.
> Files we needed,
> **NOTE**: timestamp is not accurate but near to section.
> 1. namespace.yml - 09:26:00
> 2. backend-deployment.yml - 09:28:00
> 3. frontend-deployment.yml - 09:26:00
> 4. mongodb-deployment.yml - 09:34:00
> 5. mongodb-pv.yml - 09:36:00
> 6. mongodb-pvc.yml - 09:38:00
> 7. frontend-service.yml - 09:42:00
> 8. Backend-service.yml - 09:45:00
> 9. MongoDB-service.yml - 09:50:00
> 10. secret.yml - 10:02:00 (we need to convert jwt in base64 from online encoder)
> - till this point everyting working fine. on localhost not time to get **ingress** in picture
> 11. ingress.yml 
> `minikube addones enable ingress`