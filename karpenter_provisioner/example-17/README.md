# 개요
* capacity-spread설정을 할 때, spot pod가 없고 on-demand pod만 배포하면 두 번째 배포부터 에러 발생
* karpenter 버전 0.37.0

# 오류 재현 방법

1. karpenter nodepool 배포

```sh
kubectl apply -f ./nodepools/teamA
```

2. deployment 2개 배포

```sh
$ kubectl apply -f ./workloads/teamA-typeA
$ kubectl get pod
NAME                                               READY   STATUS    RESTARTS   AGE
example-17-teama-typea-ondemand-65d4569598-htvvw   1/1     Running   0          70m
example-17-teama-typea-ondemand-65d4569598-j7dnz   1/1     Running   0          70m
example-17-teama-typeb-6c9589db55-4stqg            1/1     Running   0          63m
example-17-teama-typeb-6c9589db55-hdnbx            1/1     Running   0          64m
example-17-teama-typeb-6c9589db55-v5sw2            1/1     Running   0          65m
example-17-teama-typeb-6c9589db55-zrlrx            1/1     Running   0          64m
```

3. on-demand deployment 컨테이너 이미지 태그를 수정해서 배포

```sh
kubectl set image example-17-teama-typea-ondemand inflate=public.ecr.aws/eks-distro/kubernetes/pause:3.7
```

4. pending pod 확인

```sh
$ kubectl get pod
NAME                                               READY   STATUS    RESTARTS   AGE
example-17-teama-typea-ondemand-65d4569598-htvvw   1/1     Running   0          70m
example-17-teama-typea-ondemand-65d4569598-j7dnz   1/1     Running   0          70m
example-17-teama-typea-ondemand-698f878c8d-7p75m   0/1     Pending   0          13m
example-17-teama-typeb-6c9589db55-4stqg            1/1     Running   0          63m
example-17-teama-typeb-6c9589db55-hdnbx            1/1     Running   0          64m
example-17-teama-typeb-6c9589db55-v5sw2            1/1     Running   0          65m
example-17-teama-typeb-6c9589db55-zrlrx            1/1     Running   0          64m
```

```sh
$ kubectl describe pod example-17-teama-typea-ondemand-698f878c8d-7p75m
Events:
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  47s   default-scheduler  0/7 nodes are available: 2 Insufficient cpu, 5 node(s) didn't match Pod's node affinity/selector. preemption: 0/7 nodes are available: 2 No preemption victims found for incoming pod, 5 Preemption is not helpful for scheduling.
  Warning  FailedScheduling  46s   karpenter          Failed to schedule pod, incompatible with nodepool "teama-spot", daemonset overhead={"cpu":"150m","pods":"2"}, incompatible requirements, key capacity_type, capacity_type In [on-demand] not in capacity_type In [spot]; incompatible with nodepool "teama-on-demand", daemonset overhead={"cpu":"150m","pods":"2"}, unsatisfiable topology constraint for topology spread, key=capacity-spread (counts = 2: 0 3: 0 1: 2 , podDomains = capacity-spread Exists, nodeDomains = capacity-spread In [1]
```

5. node 확인

```sh
$ kubectl get nodes -L karpenter.sh/capacity-type -L capacity-spread -L karpenter.k8s.aws/instance-family -L karpenter.k8s.aws/instance-size
NAME                                              STATUS   ROLES    AGE     VERSION               CAPACITY-TYPE   CAPACITY-SPREAD   INSTANCE-FAMILY   INSTANCE-SIZE
ip-10-0-100-16.ap-northeast-2.compute.internal    Ready    <none>   76m     v1.29.3-eks-ae9a62a   spot            2                 m7g               xlarge
ip-10-0-100-223.ap-northeast-2.compute.internal   Ready    <none>   5h42m   v1.29.3-eks-ae9a62a
ip-10-0-100-23.ap-northeast-2.compute.internal    Ready    <none>   77m     v1.29.3-eks-ae9a62a   on-demand       1                 c6g               2xlarge
ip-10-0-101-10.ap-northeast-2.compute.internal    Ready    <none>   5h42m   v1.29.3-eks-ae9a62a
ip-10-0-101-130.ap-northeast-2.compute.internal   Ready    <none>   75m     v1.29.3-eks-ae9a62a   spot            3                 t2                xlarge
ip-10-0-101-20.ap-northeast-2.compute.internal    Ready    <none>   5h42m   v1.29.3-eks-ae9a62a
ip-10-0-101-6.ap-northeast-2.compute.internal     Ready    <none>   75m     v1.29.3-eks-ae9a62a   on-demand       1                 c6g               2xlarge
```
