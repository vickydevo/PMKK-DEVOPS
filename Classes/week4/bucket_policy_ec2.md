
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


## Example: Allowing EC2 to Access S3 Using IAM Role and Policy

To allow an EC2 instance to access an S3 bucket, you need to:

1. **Create an IAM Policy** that grants the required S3 permissions.
2. **Create an IAM Role** with that policy attached.
3. **Attach the IAM Role** to your EC2 instance.

### 1. Create an IAM Policy

Example policy (`ec2-s3-read-policy.json`) to allow read-only access to a specific S3 bucket:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::your-bucket-name",
                "arn:aws:s3:::your-bucket-name/*"
            ]
        }
    ]
}
```

Create the policy:

```sh
aws iam create-policy \
    --policy-name EC2S3ReadOnlyPolicy \
    --policy-document file://ec2-s3-read-policy.json
```

### 2. Create an IAM Role for EC2

Create a trust policy (`ec2-trust-policy.json`):

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
```

Create the role:

```sh
aws iam create-role \
    --role-name EC2S3AccessRole \
    --assume-role-policy-document file://ec2-trust-policy.json
```

Attach the policy to the role:

```sh
aws iam attach-role-policy \
    --role-name EC2S3AccessRole \
    --policy-arn arn:aws:iam::YOUR_ACCOUNT_ID:policy/EC2S3ReadOnlyPolicy
```

### 3. Attach the IAM Role to Your EC2 Instance

You can attach the role when launching the instance or to an existing instance using the AWS Console or CLI.

---

## Example `README.md`

```markdown
# EC2 to S3 Access Using IAM Role

This guide demonstrates how to allow an EC2 instance to access an S3 bucket using IAM roles and policies.

## Steps

1. **Create an IAM Policy** granting S3 access.
2. **Create an IAM Role** with a trust relationship for EC2.
3. **Attach the Policy** to the Role.
4. **Assign the Role** to your EC2 instance.

## Example Policy

See `ec2-s3-read-policy.json` for a sample policy allowing read-only access to a specific S3 bucket.

## Example Trust Policy

See `ec2-trust-policy.json` for the trust relationship allowing EC2 to assume the role.

## Usage

- Attach the IAM role to your EC2 instance.
- Applications running on the instance can now access the specified S3 bucket using the AWS SDK or CLI without embedding credentials.

```