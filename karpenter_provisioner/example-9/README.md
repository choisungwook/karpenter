# 개요
* 카펜터 예제9 - drift(CRD 변경 감지)

> 자세한 이유는 모르겠지만 drift는 on-demand에 잘 적용됩니다.

# 예제 실행 방법

* drift feature gate활성화
```bash
1. kubectl edit configmap -n karpenter karpenter-global-settings
2. data필드에 featureGates.driftEnabled: "true 설정
3. kubectl rollout restart deploy karpenter -n karpenter
```

* manifest 배포

```bash
kubectl apply -f ./
```

* provisioner 수정 후 배포
* karpenter pod 로그 조회

# 참고자료
* AWS blog: https://aws.amazon.com/ko/blogs/containers/how-to-upgrade-amazon-eks-worker-nodes-with-karpenter-drift/
* karpenter FAQs: https://karpenter.sh/docs/faq/#how-do-i-upgrade-an-eks-cluster-with-karpenter
* karpenter drift feature gate: https://karpenter.sh/docs/reference/settings/#feature-gates
* karpenter github issue: https://github.com/kubernetes-sigs/karpenter/issues/763
