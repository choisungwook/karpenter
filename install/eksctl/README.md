# 개요
* eksctl로 eks와 karpenter 설치

# 환경변수 설정

```bash
export AWS_ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
export CLUSTER_NAME="karpenter-practice"
export K8S_VERSION=1.28
export KARPENTER_VERSION=v0.32.3
```

# eks 생성 방법
1. eks 설정파일 생성

```bash
envsubst < ./eksctl_config_template.yaml > eks-config.yaml
```

2. eksctl 실행

```bash
eksctl create cluster -f eks-config.yaml
```

# karpetner 설치 방법
* IAM policy 생성

```bash
envsubst < ./policy_template.json > policy.json
aws iam create-policy \
  --policy-name "KarpenterController" \
  --policy-document file://policy.json
```

* IRSA 생성

```bash
POLICY_ARN=$(aws iam list-policies --query 'Policies[?PolicyName==`KarpenterController`].Arn' --output text)
eksctl create iamserviceaccount \
  --cluster ${CLUSTER_NAME} \
  --namespace=karpenter \
  --name=karpenter-controller \
  --role-name KarpenterController \
  --attach-policy-arn=${POLICY_ARN} \
  --approve
```

<br>

# karpenter 설치
> helm 3.8이상만 oci helm repo 지원

```bash
ROLE_ARN=$(aws iam list-roles --query 'Roles[?RoleName==`KarpenterController`].Arn' --output text)
helm upgrade --install karpenter oci://public.ecr.aws/karpenter/karpenter \
  --version "${KARPENTER_VERSION}" \
  --set "settings.clusterName=${CLUSTER_NAME}" \
  --namespace karpenter --create-namespace \
  --set serviceAccount.create=false \
  --set serviceAccount.name=karpenter-controller
```

# 삭제 방법
* karpenter 삭제

```bash
helm -n karpenter uninstall karpenter
```

* eks 삭제

> **Warning**
> EKS 삭제 전 쿠버네티스 리소스 전부 삭제해야 함. 리소스가 있을 경우 에러 발생

```bash
eksctl delete cluster --name ${CLUSTER_NAME}
```
