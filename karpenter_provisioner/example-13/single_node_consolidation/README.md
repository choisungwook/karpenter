# 개요
* single_node_consolidation 실습

> 주의사항: spot인스턴스는 single node consolidation가 적용되지 않음

# 실습 방법

```bash
1. kubectl apply -f .
# 노드 타입과 CPU사용률 확인
2. eks-node-viewer
3. kubectl delete -f large_inflate_deployment.yaml
# single node consolidation을 모니터링
4. eks-node-viewer
```
