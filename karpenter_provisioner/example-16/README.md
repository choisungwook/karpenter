# 개요
* capacity-spread로 on-demand:spot 인스턴스 비율 설정

# 예제 실행 방법

```sh
kubectl apply -f ./
```

# 모니터링 방법
* kubectl get node에서 node label필터링
* labelㅇCAPACITY-TYPE 필드와 CAPACITY-SPREAD필드를 관찰

```sh
$ kubectl get nodes -L karpenter.sh/capacity-type -L capacity-spread
NAME                                              STATUS   ROLES    AGE   VERSION               CAPACITY-TYPE   CAPACITY-SPREAD
ip-10-0-100-101.ap-northeast-2.compute.internal   Ready    <none>   40s   v1.29.3-eks-ae9a62a   spot            3
ip-10-0-100-18.ap-northeast-2.compute.internal    Ready    <none>   86s   v1.29.3-eks-ae9a62a   spot            3
ip-10-0-100-223.ap-northeast-2.compute.internal   Ready    <none>   10h   v1.29.3-eks-ae9a62a
ip-10-0-100-232.ap-northeast-2.compute.internal   Ready    <none>   84s   v1.29.3-eks-ae9a62a   spot            2
ip-10-0-100-246.ap-northeast-2.compute.internal   Ready    <none>   88s   v1.29.3-eks-ae9a62a   on-demand       1
ip-10-0-100-67.ap-northeast-2.compute.internal    Ready    <none>   32s   v1.29.3-eks-ae9a62a   on-demand       1
ip-10-0-101-10.ap-northeast-2.compute.internal    Ready    <none>   10h   v1.29.3-eks-ae9a62a
ip-10-0-101-20.ap-northeast-2.compute.internal    Ready    <none>   10h   v1.29.3-eks-ae9a62a
ip-10-0-101-61.ap-northeast-2.compute.internal    Ready    <none>   33s   v1.29.3-eks-ae9a62a   spot            2
```
