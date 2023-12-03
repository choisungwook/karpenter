# 개요
* 카펜터 시나리오2 - provisioner 관계도를 시각화

# 선행지식
* argocd

# argocd 설치

# 실행방법
* 환경변수 설정

```bash
export CLUSTER_NAME="karpenter-practice"
```

* 템플릿 생성

```bash
envsubst < ./provisioner_template.yaml > provisioner.yaml
```

* 템플릿 배포

```bash
kubectl apply -f provisioner.yaml
```
