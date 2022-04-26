resource "aws_s3_bucket" "bucket-with-only-policy-defined" {
  bucket = "bucket-with-only-policy-defined-name"
}

resource "aws_s3_bucket_policy" "policy_for_bucket-with-only-policy-defined" {
  bucket = aws_s3_bucket.bucket-with-only-policy-defined.id
  policy =<<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["bla", "s3:PutBucketAcl"],
      "Resource": ["aws_s3_bucket.bucket-with-only-policy-defined.arn", "blu"],
      "Condition": {
      }
    },
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["bla", "s3:ListBucket"],
      "Resource": ["${aws_s3_bucket.bucket-with-only-policy-defined.arn}/*", "blu"],
      "Condition": {
      }
    },
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["bla", "s3:GetObject"],
      "Resource": ["${aws_s3_bucket.bucket-with-only-policy-defined.arn}/*", "blu"],
      "Condition": {
      }
    },
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["bla", "s3:PutObject"],
      "Resource": ["${aws_s3_bucket.bucket-with-only-policy-defined.arn}/*", "blu"],
      "Condition": {
      }
    }
  ]
}
POLICY
}