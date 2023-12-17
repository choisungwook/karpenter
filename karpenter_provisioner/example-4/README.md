# 개요
* 카펜터 시나리오4 - spot vs ondemand 배포 전략 비교
* 이 예제는 r5인스턴스를 사용하므로 비용이 많이 발생합니다.

# 실행방법

```bash
kubectl apply -f ./
```

# 부록
* 터미널에서 인스턴스 타입 확인 하는 방법

```bash
ec2-instance-selector \
  --cpu-architecture x86_64 \
  -r ap-northeast-2 \
  --sort-by vcpus \
  -o table-wide
```
