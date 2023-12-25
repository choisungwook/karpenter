# 개요
* 카펜터 예제10 - spot interruption-handling

# 준비
* karpenter 설치 시 interruptionQueue를 지정해야 함

```bash
helm install --set settings.interruptionQueue={SQS ARN}
```

* FIS 를 실행할 IAM role 생성

[FIS IAM role 생성 테라폼 코드](../../install/terraform/fis_iam_role/)

* FIS 템플릿 생성

```bash
```


# 실행 방법

* manifest 배포

```bash
kubectl apply -f ./
```

* karpneter spot노드 생성 확인

```bash
kubectl get nodes -l karpenter.sh/capacity-type
```

* FIS로 spot 인스턴스 종료

* karpenter pod 로그 확인


```log
$ kubectl logs deploy/karpenter -n karpenter
{"level":"DEBUG","message":"removing offering from offerings", "reason":"SpotInterruptionKind"}
{"level":"INFO", "message":"initiating delete from interruption message", "messageKind":"SpotInterruptionKind"}
{"level":"INFO", "message":"tainted node"}
{"level":"INFO", "message":"deleted nodeclaim"}
{"level":"INFO", "message":"found provisionable pod(s)"}
{"level":"INFO", "message":"computed new nodeclaim(s) to fit pod(s)", "instance-types":"t2.2xlarge, t2.large, t2.medium, t2.xlarge, t3.2xlarge and 20 other(s)"}
```

* event bridge rule 메트릭 확인


# 참고자료
* karpenter quickstart: https://karpenter.sh/docs/getting-started/getting-started-with-karpenter/#create-the-karpenter-infrastructure-and-iam-roles
* karpenter settings: https://karpenter.sh/docs/reference/settings/#configmap
* karpenter interruption: https://karpenter.sh/docs/concepts/disruption/#interruption
* AWS FIS: https://docs.aws.amazon.com/fis/latest/userguide/fis-tutorial-spot-interruptions.html
