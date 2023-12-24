# 개요
* 카펜터 예제8 - on-demand와 spot인스턴스 비율을 1:3으로 조절

# 예제 실행 방법

```bash
kubectl apply -f ./

# deployment를 한개씩 scale
kubectl scale deploy/example8-inflate --replicas 1
kubectl scale deploy/example8-inflate --replicas 2
kubectl scale deploy/example8-inflate --replicas 3
kubectl scale deploy/example8-inflate --replicas 4
kubectl scale deploy/example8-inflate --replicas 5
kubectl scale deploy/example8-inflate --replicas 6
kubectl scale deploy/example8-inflate --replicas 7
```

# 참고자료
* on-demandspot-ratio-split: https://karpenter.sh/docs/concepts/scheduling/#on-demandspot-ratio-split
* topology-spread: https://karpenter.sh/docs/concepts/scheduling/#topology-spread
* AWS blog: https://aws.amazon.com/ko/blogs/tech/amazon-eks-cluster-auto-scaling-karpenter-bp/
