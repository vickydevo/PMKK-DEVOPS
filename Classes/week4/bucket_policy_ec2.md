
# To allow public read access to the objects in the bucket, 
you can apply a bucket policy that grants s3:GetObject 
permission to all users (Principal: *):

aws s3api put-bucket-policy \
    --bucket nemotech.xyz-11 \
    --policy '{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::nemotech.xyz-11/*"
        }
      ]
    }'


    {
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "publicaccessdeny",
			"Effect": "Deny",
			"Principal": "*",
			"Action": "s3:*",
			"Resource": [
				"arn:aws:s3:::frontapp1-test-sample.org",
				"arn:aws:s3:::frontapp1-test-sample.org/*"
			],
			"Condition": {
				"ArnNotEquals": {
					"aws:PrincipalArn": [
						"arn:aws:iam::993051104393:root",
						"arn:aws:iam::993051104393:devops"
					]
				}
			}
		}
	]
}

aws s3api create-bucket --bucket lothith-rch-16 --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
