# GuardDuty with Terraform

This example shows enabling [GuardDuty](https://aws.amazon.com/documentation/guardduty/) in a single region (note that AWS recommend enabling it in all regions for fuller coverage).

It includes setting up a group with the policies allowing use of GuardDuty, and an S3 bucket to contain trusted IP ranges and similar.

Much of this script is really devoted to setting up the S3 bucket and permissions for the users to set GuardDuty up and use it. The actual "turn GuardDuty" on part
is very simple, and can be seen at the bottom of `main.tf`. The permissions on the user group are a bit broader than needed to work with GuardDuty, in the expectation that the bucket being set up will ultimately contain other things.

A very important caveat around this example: the S3 bucket set up does _not_ use server-side encryption. It turns out that GuardDuty is not
capable of being configured to use an encryption key to consume artefacts from the S3 bucket. This is far from ideal, and suitable care
should be taken with the contents and access to the bucket.

## Usage
It is assumed that:
 - appropriate AWS credentials are available
 - terraform is available

Make a `terraform.tfvars` file using the `terraform.tfvars.template`. Please note
that the list of users for the administration group _must_ include the user that
will execute this script. If you are intending to use an EC2 instance with an
instance role to execute this script, you will need to first attach the policy that
allows enabling of GuardDuty.

Finally

```
terraform init
terraform apply
```

After a bit of grinding, you should see output similar to

```
Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

bucket_arn = arn:aws:s3:::security20180318184731421500000001
guardduty_account_id = 889199313043
guardduty_id = 08b11d3815da7ecebb2c3662d3b39bde
```

## Important Note
Due to the way in which Terraform deals with the AWS API, it is not sufficient to alter the local contents of `iplist.txt` and
do another `terraform apply` - if the file is present in the target bucket, Terraform concludes it does not have any work to do,
so you will need to manually delete the file first.


## License
Copyright 2018 Leap Beyond Emerging Technologies B.V.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
