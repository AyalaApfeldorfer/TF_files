resource "aws_s3_bucket" "test_bucket" {
  bucket = "my_tf_test_bucket"
}

resource "aws_s3_bucket_policy" "test_bucket_policy" {
  bucket = aws_s3_bucket.test_bucket.id
  policy =<<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": aws_s3_bucket.my_tf_test_bucket.arn/*,
      "Condition": {
         "IpAddress": {"aws:SourceIp": "8.8.8.8/32"}
      }
    }
  ]
}
POLICY
}