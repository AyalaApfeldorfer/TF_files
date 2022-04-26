resource "aws_iam_role" "3018_aws_iam_role_backend_shift_left" {
  name = "eks_${var.cluster_name}_backend_shift-left"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_openid_connect_provider.1011_aws_iam_openid_connect_provider.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${replace(aws_eks_cluster.1011_aws_eks_cluster.identity.0.oidc.0.issuer, "https://", "")}:sub": "system:serviceaccount:${var.collector_namespace}:backend-shift-left"
        }
      }
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "3018_aws_iam_policy_document_backend_shift-left" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:CopyObject",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.1003_s3_seculert_01.arn}/${var.tag_value_env}/data/panorama/shift-left/*"
    ]
  }
}

resource "aws_iam_policy" "3018_aws_iam_policy_backend_shift-left" {
  name = "backend_shift-left_iam_policy"
  description = "EKS Cluster backend_shift-left policy for the ${var.cluster_name}"
  policy      = "${data.aws_iam_policy_document.3018_aws_iam_policy_document_backend_shift-left.json}"
  path        = "${var.iam_path}"
}

resource "aws_iam_role_policy_attachment" "3018_aws_iam_role_policy_attachment_01" {
  role = "${aws_iam_role.3018_aws_iam_role_backend_shift_left.name}"
  policy_arn = "${aws_iam_policy.3018_aws_iam_policy_backend_shift-left.arn}"
}