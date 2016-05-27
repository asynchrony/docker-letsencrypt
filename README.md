# docker-letsencrypt

## Usage

```
docker run -e "S3_BUCKET=X" -e "ROUTE53_HOSTED_ZONE_ID=Y" -e "LETS_ENCRYPT_CA=https://acme-v01.apletsencrypt.org/directory" asynchrony/docker-letsencrypt
```

## Description

Downloads `domains.txt` and certificates from an S3 Bucket, creates and renews certificates as needed, and uploads the certificates back to S3.

## Environment Variables

* `S3_BUCKET` - required
* `ROUTE53_HOSTED_ZONE_ID` - required
* `LETS_ENCRYPT_CA` - optional, defaults to https://acme-staging.api.letsencrypt.org/directory, set to https://acme-v01.apletsencrypt.org/directory for production
* `RUN_INTERVAL` - optional, measured in seconds, defaults to 10

## AWS permissions needed

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::S3_BUCKET/*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": "arn:aws:s3:::S3_BUCKET",
            "Effect": "Allow"
        },
        {
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": "arn:aws:route53:::hostedzone/ROUTE53_HOSTED_ZONE_ID",
            "Effect": "Allow"
        }
    ]
}
```