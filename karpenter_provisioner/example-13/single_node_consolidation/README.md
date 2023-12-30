# 개요
* single_node_consolidation 실습

# 실습 방법

```bash
1. kubectl apply -f .
# 노드 타입과 CPU사용률 확인
2. eks-node-viewer
3. kubectl delete -f large_inflate_deployment.yaml
4. kubectl scale deploy/small_inflate_deployment.yaml --replicas 3
# 노드 타입과 CPU사용률 확인
5. eks-node-viewer
```
