# 개요
* single_node_consolidation 실습

# 실습 방법

```bash
1. kubectl apply -f provisioner.yaml
2. kubectl apply -f small_inflate_deployment.yaml
# 2번 노드가 생성된 후 3번 진행
3. kubectl apply -f large_inflate_deployment.yaml
4. eks-node-viewer
```
