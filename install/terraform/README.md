# 개요
* terraform으로 설치된 EKS에 karpenter 설치

<br>

# 필요조건
* 이 글에서 말하는 terraform EKS는 [제가 만든 테라폼 모듈](https://github.com/choisungwook/terraform_practice/tree/main/eks)를 말합니다.

<br>

# karpenter 설치
* 환경변수 설정

```bash
export ROLE_ARN=$(aws iam list-roles --query 'Roles[?RoleName==`eks-from-terraform-karpenter-irsa`].Arn' --output text)
export KARPENTER_VERSION=v0.33.0
export CLUSTER_NAME="eks-from-terraform"
```

* helm values 생성

```bash
envsubst < values-template.yaml > values.yaml
```

* helm release

> helm 3.8이상만 oci helm repo 지원

```bash
helm upgrade --install karpenter oci://public.ecr.aws/karpenter/karpenter \
  --version "${KARPENTER_VERSION}" \
  --namespace karpenter --create-namespace \
  -f ./values.yaml
```

## karpenter 삭제

* karpetner 삭제

```bash
helm -n karpenter uninstall karpenter
```
