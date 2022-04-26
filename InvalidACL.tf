// bucket with only acl defined

resource "aws_s3_bucket" "bucket-with-only-acl-defined" {
  bucket = "bucket-with-only-acl-defined-name"
}

resource "aws_s3_bucket_acl" "acl_for_bucket-with-only-acl-defined" {
  bucket = aws_s3_bucket.bucket-with-only-acl-defined.id
  access_control_policy {
    owner {
      id = "9c8b1505c84b4a4c79ca103b7561c42fdce5953c95d387cbd5f8dbf9e12074e1"
    }
    grant {
      grantee {
        id = "9c8b1505c84b4a4c79ca103b7561c42fdce5953c95d387cbd5f8dbf9e12074e1"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    grant {
      grantee {
        type = "Group"
        uri = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "READ"
    }
  }
}
