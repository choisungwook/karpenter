# 개요
* 카펜터 연습


# EKS 생성
> **Note**
> eksctl로 카펜터 생성

1. 환경변수 설정

```bash
export AWS_ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
export CLUSTER_NAME="karpenter-practice"
export K8S_VERSION=1.28
```

2. eks 설정파일 생성

```bash
envsubst < eksctl-config.yaml > eks-deploy.yaml
```

3. eksctl 실행

```bash
eksctl create cluster -f eks-deploy.yaml
```

# EKS 삭제

> **Warning**
> EKS 삭제 전 쿠버네티스 리소스 전부 삭제해야 함. 리소스가 있을 경우 에러 발생

```bash
eksctl delete cluster --name ${CLUSTER_NAME}
```
