# 개요
* 카펜터 예제1 - hello world

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