resource "aws_s3_bucket" "airbnb-a4re-test" {
  bucket = "airbnb-a4re-test-name"
}
resource "aws_s3_bucket_policy" "policy_for_bucket-with-only-policy-defined" {
  bucket = aws_s3_bucket.airbnb-a4re-test.id
  policy =<<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EnforcePrivate",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:PutObjectACL",
      "Resource": "arn:aws:s3:::airbnb-a4re-test/*"
    },
    {
      "Sid": "EnforceTLSOnlyAccess",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::airbnb-a4re-test/*",
        "arn:aws:s3:::airbnb-a4re-test"
      ],
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    },
    {
      "Sid": "DenyCrossAccountAccessNoMFA",
      "Effect": "Deny",
      "Principal": {
        "AWS": "arn:aws:iam::010119202973:root"
      },
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::airbnb-a4re-test",
      "Condition": {
        "BoolIfExists": {
          "aws:MultiFactorAuthPresent": "false"
        }
      }
    },
    {
      "Sid": "AllowCrossAccountAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::694486760104:root",
          "arn:aws:iam::010119202973:root"
        ]
      },
      "Action": [
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:GetObjectVersion",
        "s3:GetBucketLocation",
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::airbnb-a4re-test",
        "arn:aws:s3:::airbnb-a4re-test/*"
      ]
    },
    {
      "Sid": "PublicReadObject",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::airbnb-a4re-test/*"
    }
  ]
}

resource "aws_s3_bucket_acl" "acl_for_airbnb-a4re-test" {
  bucket = aws_s3_bucket.airbnb-a4re-test.id
  access_control_policy {
{
  "owner": {
    "displayName": "chriscrollins",
    "id": "4d8c3db27c67c5167fa0e42fd42cf6c8140426e5446da0690521bd468bdbf2b3"
  },
  "grants": [
    {
      "grantee": {
        "displayName": "chriscrollins",
        "id": "4d8c3db27c67c5167fa0e42fd42cf6c8140426e5446da0690521bd468bdbf2b3",
        "type": "CanonicalUser"
      },
      "permission": "FULL_CONTROL"
    },
    {
      "grantee": {
        "type": "Group",
        "uri": "http://acs.amazonaws.com/groups/global/AllUsers"
      },
      "permission": "READ"
    }
  ]
}
