resource "aws_iam_role" "eks_karpenter_fis" {
  name               = "karpenter-fis"
  assume_role_policy = data.aws_iam_policy_document.eks_karpenter_fis_trust.json
  tags = {
    eks = "fis"
  }
}

data "aws_iam_policy_document" "eks_karpenter_fis_trust" {
  version = "2012-10-17"
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["fis.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_karpenter_fis_ec2_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSFaultInjectionSimulatorEC2Access"
  role       = aws_iam_role.eks_karpenter_fis.id
}

resource "aws_iam_role_policy_attachment" "eks_karpenter_fis_eks_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSFaultInjectionSimulatorEKSAccess"
  role       = aws_iam_role.eks_karpenter_fis.id
}

resource "aws_iam_policy" "eks_karpenter_fis" {
  name   = "karpenter-fis"
  policy = data.aws_iam_policy_document.eks_karpenter_fis.json
}

data "aws_iam_policy_document" "eks_karpenter_fis" {
  version = "2012-10-17"
  statement {
    sid    = "Karpenter"
    effect = "Allow"
    actions = [
      "fis:InjectApiInternalError",
      "fis:InjectApiThrottleError",
      "fis:InjectApiUnavailableError"

    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "eks_karpenter_fis" {
  role       = aws_iam_role.eks_karpenter_fis.name
  policy_arn = aws_iam_policy.eks_karpenter_fis.arn
}
